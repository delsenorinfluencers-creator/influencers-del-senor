create extension if not exists pgcrypto;

create table if not exists public.admins(
 id uuid primary key references auth.users(id) on delete cascade,
 email text, role text not null default 'editor'
 check(role in('superadmin','editor','programas','en_vivo')),
 active boolean not null default true, created_at timestamptz default now()
);

create or replace function public.is_admin(uid uuid) returns boolean
language sql security definer set search_path=public stable as $$
 select exists(select 1 from public.admins where id=uid and active=true);
$$;
grant execute on function public.is_admin(uuid) to anon,authenticated;

create table if not exists public.programs(
 id uuid primary key default gen_random_uuid(), name text unique not null,
 description text, image_url text, published boolean default true,
 sort_order int default 0, created_at timestamptz default now()
);
create table if not exists public.episodes(
 id uuid primary key default gen_random_uuid(),
 program_id uuid references public.programs(id) on delete cascade,
 title text not null, description text, image_url text,
 youtube_url text, facebook_url text, video_url text,
 published boolean default true, sort_order int default 0,
 created_at timestamptz default now()
);
create table if not exists public.news(
 id uuid primary key default gen_random_uuid(), title text not null,
 summary text, content text, category text default 'diocesana'
 check(category in('diocesana','nacional','internacional')),
 image_url text, youtube_url text, facebook_url text,
 published boolean default true, created_at timestamptz default now(),
 updated_at timestamptz default now()
);
create table if not exists public.live_streams(
 id uuid primary key default gen_random_uuid(), title text not null,
 type text default 'facebook' check(type in('facebook','youtube','m3u8','loop')),
 url text, m3u8_url text, loop_url text, image_url text,
 active boolean default false, show_home boolean default false,
 show_live boolean default true, created_at timestamptz default now()
);
create table if not exists public.historical_data(
 id uuid primary key default gen_random_uuid(), number int unique not null check(number between 1 and 64),
 title text not null, body text, image_url text, video_url text,
 published boolean default false, active_from date, active_until date,
 created_at timestamptz default now()
);
create table if not exists public.diocese_content(
 id uuid primary key default gen_random_uuid(), title text not null,
 type text default 'historia' check(type in('historia','parroquia','advocacion')),
 body text, image_url text, published boolean default true, created_at timestamptz default now()
);
create table if not exists public.team_members(
 id uuid primary key default gen_random_uuid(), name text not null, role text,
 bio text, image_url text, social_url text, published boolean default true,
 sort_order int default 0, created_at timestamptz default now()
);
create table if not exists public.editorials(
 id uuid primary key default gen_random_uuid(), title text not null, author text,
 body text, image_url text, published boolean default true, created_at timestamptz default now()
);
create table if not exists public.site_settings(
 id int primary key default 1 check(id=1), site_name text,
 whatsapp text, facebook text, youtube text, logo text,
 seo_description text, contact text, updated_at timestamptz default now()
);

insert into public.site_settings(id,site_name,logo,facebook)
values(1,'Jóvenes Influencers del Señor',
'https://i.ibb.co/tw6GTfyV/Dise-o-sin-t-tulo-12.png',
'https://www.facebook.com/jovenesinfluencersdelsenor')
on conflict(id) do nothing;

insert into public.programs(name,sort_order) values
('Un café con aroma de fe',1),('El Podcast',2),('El Youcat te conecta',3),
('La voz líder',4),('Hagan lo que Él les diga',5),('Una palabra en 60 segundos',6),
('Fe y vida diaria',7),('La Santa Misa',8),('Kerigma en fuego',9),
('Semilla vocacional',10),('Cultiva la fe',11) on conflict(name) do nothing;

insert into public.historical_data(number,title,active_from,active_until)
select n,'64 Datos Históricos - Dato '||n,'2026-10-01','2026-10-31'
from generate_series(1,64)n on conflict(number) do nothing;

do $$ declare t text; begin
 foreach t in array array['programs','episodes','news','live_streams','historical_data',
 'diocese_content','team_members','editorials','site_settings'] loop
  execute format('alter table public.%I enable row level security',t);
  execute format('drop policy if exists "public_read" on public.%I',t);
  execute format('create policy "public_read" on public.%I for select to anon,authenticated using (true)',t);
  execute format('drop policy if exists "admin_write" on public.%I',t);
  execute format('create policy "admin_write" on public.%I for all to authenticated using(public.is_admin(auth.uid())) with check(public.is_admin(auth.uid()))',t);
 end loop;
end $$;

alter table public.admins enable row level security;
drop policy if exists "admin_read_admins" on public.admins;
create policy "admin_read_admins" on public.admins for select to authenticated using(public.is_admin(auth.uid()));
drop policy if exists "admin_insert_admins" on public.admins;
create policy "admin_insert_admins" on public.admins for insert to authenticated with check(public.is_admin(auth.uid()));
drop policy if exists "admin_update_admins" on public.admins;
create policy "admin_update_admins" on public.admins for update to authenticated using(public.is_admin(auth.uid())) with check(public.is_admin(auth.uid()));
drop policy if exists "admin_delete_admins" on public.admins;
create policy "admin_delete_admins" on public.admins for delete to authenticated using(public.is_admin(auth.uid()));

insert into storage.buckets(id,name,public) values('media','media',true)
on conflict(id) do update set public=true;
drop policy if exists "media_public_read" on storage.objects;
create policy "media_public_read" on storage.objects for select to public using(bucket_id='media');
drop policy if exists "media_admin_insert" on storage.objects;
create policy "media_admin_insert" on storage.objects for insert to authenticated
with check(bucket_id='media' and public.is_admin(auth.uid()));
drop policy if exists "media_admin_update" on storage.objects;
create policy "media_admin_update" on storage.objects for update to authenticated
using(bucket_id='media' and public.is_admin(auth.uid()))
with check(bucket_id='media' and public.is_admin(auth.uid()));
drop policy if exists "media_admin_delete" on storage.objects;
create policy "media_admin_delete" on storage.objects for delete to authenticated
using(bucket_id='media' and public.is_admin(auth.uid()));

-- Autoriza el primer administrador. Cambia UUID/correo si corresponde.
insert into public.admins(id,email,role)
values('d0b9f5b1-3b40-4ffd-bb5f-23099558163d','edinandres789@gmail.com','superadmin')
on conflict(id) do update set role='superadmin',active=true,email=excluded.email;
