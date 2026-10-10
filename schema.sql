-- Esquema completo para Jóvenes Influencers del Señor.
-- Ejecutar UNA VEZ en Supabase > SQL Editor.
create extension if not exists pgcrypto;

create table if not exists public.admins(
 id uuid primary key references auth.users(id) on delete cascade,
 email text,
 role text not null default 'admin',
 created_at timestamptz not null default now()
);
alter table public.admins add column if not exists email text;
alter table public.admins add column if not exists role text default 'admin';
alter table public.admins enable row level security;

create or replace function public.is_admin() returns boolean language sql stable security definer set search_path=public as $$
 select exists(select 1 from public.admins a where a.id=auth.uid());
$$;

-- Bootstrap: cambia el correo si es necesario. Si el usuario ya existe, queda administrador.
insert into public.admins(id,email,role)
select id,email,'admin' from auth.users where email='edinandres789@gmail.com'
on conflict (id) do update set email=excluded.email, role='admin';

drop policy if exists admins_self_read on public.admins;
create policy admins_self_read on public.admins for select to authenticated using (id=auth.uid() or public.is_admin());
drop policy if exists admins_admin_write on public.admins;
create policy admins_admin_write on public.admins for all to authenticated using (public.is_admin()) with check (public.is_admin());

create table if not exists public.site_settings(
 id boolean primary key default true,
 site_name text default 'Jóvenes Influencers del Señor',
 logo_url text,
 logo64_url text,
 facebook_url text,
 youtube_url text,
 whatsapp text,
 site_description text,
 footer_creator text default 'Gamarra TV',
 updated_at timestamptz default now()
);
insert into public.site_settings(id,site_name,logo_url,logo64_url,facebook_url,footer_creator)
values(true,'Jóvenes Influencers del Señor','https://i.ibb.co/tw6GTfyV/Dise-o-sin-t-tulo-12.png','https://i.ibb.co/HfhqmYQs/file-000000006d4c81f5b9452f237ee19824.png','https://www.facebook.com/jovenesinfluencersdelsenor','Gamarra TV')
on conflict(id) do nothing;

create table if not exists public.news(
 id uuid primary key default gen_random_uuid(), title text not null, slug text unique, excerpt text, content text, image_url text,
 category text default 'Diócesis de Ocaña', author_name text, author_id uuid references auth.users(id), published_at timestamptz,
 published boolean default false, created_at timestamptz default now(), updated_at timestamptz default now()
);
alter table public.news add column if not exists slug text;
alter table public.news add column if not exists excerpt text;
alter table public.news add column if not exists content text;
alter table public.news add column if not exists image_url text;
alter table public.news add column if not exists category text default 'Diócesis de Ocaña';
alter table public.news add column if not exists author_name text;
alter table public.news add column if not exists author_id uuid references auth.users(id);
alter table public.news add column if not exists published_at timestamptz;
alter table public.news add column if not exists published boolean default false;

create table if not exists public.news_categories(id uuid primary key default gen_random_uuid(), name text unique not null, created_at timestamptz default now());
insert into public.news_categories(name) values ('Diócesis de Ocaña'),('Noticias nacionales'),('Noticias internacionales'),('Noticias del Vaticano') on conflict(name) do nothing;
create table if not exists public.news_tags(id uuid primary key default gen_random_uuid(), name text unique not null, created_at timestamptz default now());
create table if not exists public.news_tag_relations(news_id uuid references public.news(id) on delete cascade, tag_id uuid references public.news_tags(id) on delete cascade, primary key(news_id,tag_id));

create table if not exists public.programs(
 id uuid primary key default gen_random_uuid(), name text not null, slug text unique, description text, image_url text, sort_order integer default 0, published boolean default true, created_at timestamptz default now(), updated_at timestamptz default now()
);
alter table public.programs add column if not exists sort_order integer default 0;
alter table public.programs add column if not exists published boolean default true;
insert into public.programs(name,slug,sort_order) values
('Un café con aroma de fe','un-cafe-con-aroma-de-fe',1),('El Podcast','el-podcast',2),('El Youcat te conecta','el-youcat-te-conecta',3),('La voz líder','la-voz-lider',4),('Hagan lo que Él les diga','hagan-lo-que-el-les-diga',5),('Una palabra en 60 segundos','una-palabra-en-60-segundos',6),('Fe y vida diaria','fe-y-vida-diaria',7),('La Santa Misa','la-santa-misa',8),('Kerigma en fuego','kerigma-en-fuego',9),('Semilla vocacional','semilla-vocacional',10),('Cultiva la fe','cultiva-la-fe',11)
on conflict(slug) do nothing;
create table if not exists public.episodes(
 id uuid primary key default gen_random_uuid(), program_id uuid references public.programs(id) on delete cascade, title text not null, description text, video_url text, video_type text default 'youtube', image_url text, sort_order integer default 0, published boolean default true, created_at timestamptz default now()
);

create table if not exists public.live_streams(
 id uuid primary key default gen_random_uuid(), title text default 'Señal en vivo', program_name text, type text default 'm3u8', url text, image_url text, loop_url text,
 show_live boolean default false, show_live_page boolean default false, active boolean default false, muted boolean default true, created_at timestamptz default now(), updated_at timestamptz default now()
);
alter table public.live_streams add column if not exists program_name text;
alter table public.live_streams add column if not exists type text default 'm3u8';
alter table public.live_streams add column if not exists url text;
alter table public.live_streams add column if not exists image_url text;
alter table public.live_streams add column if not exists loop_url text;
alter table public.live_streams add column if not exists show_live boolean default false;
alter table public.live_streams add column if not exists show_live_page boolean default false;
alter table public.live_streams add column if not exists active boolean default false;
alter table public.live_streams add column if not exists muted boolean default true;

create table if not exists public.historical_64(
 id integer primary key, title text, content text, image_url text, video_url text, published boolean default false, available_from date, available_until date
);
create table if not exists public.diocesan_pages(id uuid primary key default gen_random_uuid(), section text unique not null, title text, content text, image_url text, updated_at timestamptz default now());
create table if not exists public.parishes(id uuid primary key default gen_random_uuid(), name text not null, location text, description text, image_url text, published boolean default true, created_at timestamptz default now());
create table if not exists public.team_members(id uuid primary key default gen_random_uuid(), name text not null, role text, biography text, photo_url text, facebook_url text, instagram_url text, youtube_url text, published boolean default true, sort_order integer default 0);
create table if not exists public.editorials(id uuid primary key default gen_random_uuid(), title text not null, slug text unique, content text, image_url text, author_name text, published_at timestamptz, published boolean default false, created_at timestamptz default now());

-- RLS: contenido público de lectura; escritura únicamente para administradores.
do $$ declare t text; begin
 foreach t in array array['site_settings','news','news_categories','news_tags','news_tag_relations','programs','episodes','live_streams','historical_64','diocesan_pages','parishes','team_members','editorials'] loop
  execute format('alter table public.%I enable row level security',t);
  execute format('drop policy if exists public_read on public.%I',t);
  execute format('create policy public_read on public.%I for select to anon,authenticated using (true)',t);
  execute format('drop policy if exists admin_write on public.%I',t);
  execute format('create policy admin_write on public.%I for all to authenticated using (public.is_admin()) with check (public.is_admin())',t);
 end loop;
end $$;

insert into public.historical_64(id,title,published,available_from,available_until)
select g,'Dato histórico '||g,false,'2026-10-01','2026-10-31' from generate_series(1,64) g
on conflict(id) do nothing;

-- Storage: bucket público para imágenes.
insert into storage.buckets(id,name,public) values('media','media',true) on conflict(id) do update set public=true;
drop policy if exists media_public_read on storage.objects;
create policy media_public_read on storage.objects for select using (bucket_id='media');
drop policy if exists media_admin_insert on storage.objects;
create policy media_admin_insert on storage.objects for insert to authenticated with check (bucket_id='media' and public.is_admin());
drop policy if exists media_admin_update on storage.objects;
create policy media_admin_update on storage.objects for update to authenticated using (bucket_id='media' and public.is_admin()) with check (bucket_id='media' and public.is_admin());
drop policy if exists media_admin_delete on storage.objects;
create policy media_admin_delete on storage.objects for delete to authenticated using (bucket_id='media' and public.is_admin());

-- Índices y RPC opcional para mantener slugs.
create index if not exists news_published_at_idx on public.news(published,published_at desc);
create index if not exists episodes_program_idx on public.episodes(program_id,sort_order);
create index if not exists programs_sort_idx on public.programs(sort_order);
