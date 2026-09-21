
create extension if not exists pgcrypto;

create table if not exists public.admins(id uuid primary key references auth.users(id) on delete cascade);

create table if not exists public.news(
 id uuid primary key default gen_random_uuid(), title text not null, excerpt text, content text,
 category text not null default 'diocesanas' check(category in ('diocesanas','nacionales','internacionales')),
 image_url text, youtube_url text, facebook_url text, published boolean not null default true,
 published_at timestamptz default now(), created_at timestamptz default now(), updated_at timestamptz default now()
);

create table if not exists public.programs(
 id uuid primary key default gen_random_uuid(), name text not null unique, slug text not null unique,
 description text, logo_url text, published boolean not null default true, sort_order integer not null default 0,
 created_at timestamptz default now(), updated_at timestamptz default now()
);

create table if not exists public.episodes(
 id uuid primary key default gen_random_uuid(), program_id uuid not null references public.programs(id) on delete cascade,
 title text not null, description text, image_url text, youtube_url text, facebook_url text,
 video_url text, episode_number integer, published boolean not null default true,
 sort_order integer not null default 0, published_at timestamptz default now(), created_at timestamptz default now(), updated_at timestamptz default now()
);

create table if not exists public.historical_64(
 id uuid primary key default gen_random_uuid(), number integer unique not null check(number between 1 and 64),
 title text not null, content text, image_url text, youtube_url text, facebook_url text,
 video_url text, published boolean not null default true, active_in_october boolean not null default true,
 created_at timestamptz default now(), updated_at timestamptz default now()
);

create table if not exists public.editorials(
 id uuid primary key default gen_random_uuid(), title text not null, excerpt text, content text,
 image_url text, author text, published boolean not null default true,
 published_at timestamptz default now(), created_at timestamptz default now(), updated_at timestamptz default now()
);

create table if not exists public.members(
 id uuid primary key default gen_random_uuid(), name text not null, role text, photo_url text, bio text,
 social_url text, published boolean not null default true, sort_order integer default 0,
 created_at timestamptz default now(), updated_at timestamptz default now()
);

create table if not exists public.parishes(
 id uuid primary key default gen_random_uuid(), name text not null, municipality text, address text,
 image_url text, description text, website_url text, published boolean not null default true,
 sort_order integer default 0, created_at timestamptz default now(), updated_at timestamptz default now()
);

create table if not exists public.marian_advocations(
 id uuid primary key default gen_random_uuid(), name text not null, description text, image_url text,
 published boolean not null default true, sort_order integer default 0, created_at timestamptz default now(), updated_at timestamptz default now()
);

create table if not exists public.diocese_info(
 id integer primary key default 1 check(id=1), history text, bishop text, description text,
 updated_at timestamptz default now()
);

create table if not exists public.clergy(
 id uuid primary key default gen_random_uuid(), name text not null, role text, photo_url text,
 bio text, parish text, published boolean not null default true, sort_order integer default 0,
 created_at timestamptz default now(), updated_at timestamptz default now()
);

create table if not exists public.live_streams(
 id uuid primary key default gen_random_uuid(), title text not null default 'Jóvenes Influencers del Señor',
 description text, source_type text not null default 'm3u8' check(source_type in ('m3u8','loop','facebook','youtube')),
 m3u8_url text, loop_url text, facebook_url text, youtube_url text, image_url text,
 active boolean not null default false, show_home boolean not null default true, show_live boolean not null default true,
 priority integer not null default 1, updated_at timestamptz default now(), created_at timestamptz default now()
);

create table if not exists public.site_settings(
 id integer primary key default 1 check(id=1), site_name text default 'Jóvenes Influencers del Señor',
 logo_url text, facebook_url text, youtube_url text, whatsapp text, email text,
 phone text, address text, description text, seo_title text, seo_description text,
 organization_name text, organization_url text, updated_at timestamptz default now()
);

insert into public.programs(name,slug,description,sort_order) values
('Un café con aroma de fe','un-cafe-con-aroma-de-fe','Un espacio para conversar desde la fe.',1),
('El Podcast','el-podcast','Conversaciones y contenidos en formato podcast.',2),
('El Youcat te conecta','el-youcat-te-conecta','La fe explicada para jóvenes.',3),
('La voz líder','la-voz-lider','Voces que inspiran y sirven.',4),
('Hagan lo que Él les diga','hagan-lo-que-el-les-diga','Reflexiones y testimonios.',5),
('Una palabra en 60 segundos','una-palabra-en-60-segundos','Evangelización breve para cada día.',6),
('Fe y vida diaria','fe-y-vida-diaria','La fe llevada a la vida cotidiana.',7),
('La Santa Misa','la-santa-misa','Celebraciones y contenidos eucarísticos.',8),
('Kerigma en fuego','kerigma-en-fuego','Anuncio del Evangelio con alegría.',9),
('Semilla vocacional','semilla-vocacional','Historias y formación vocacional.',10),
('Cultiva la fe','cultiva-la-fe','Formación y crecimiento espiritual.',11)
on conflict (name) do nothing;

alter table public.news enable row level security;
alter table public.programs enable row level security;
alter table public.episodes enable row level security;
alter table public.historical_64 enable row level security;
alter table public.editorials enable row level security;
alter table public.members enable row level security;
alter table public.parishes enable row level security;
alter table public.marian_advocations enable row level security;
alter table public.diocese_info enable row level security;
alter table public.clergy enable row level security;
alter table public.live_streams enable row level security;
alter table public.site_settings enable row level security;
alter table public.admins enable row level security;

create or replace function public.is_admin() returns boolean language sql security definer set search_path=public as $$
 select exists(select 1 from public.admins where id=auth.uid());
$$;

do $$ declare t text; begin
 for t in select unnest(array['news','programs','episodes','historical_64','editorials','members','parishes','marian_advocations','diocese_info','clergy','live_streams','site_settings']) loop
   execute format('drop policy if exists "public_select_%s" on public.%I',t,t);
   execute format('drop policy if exists "admin_all_%s" on public.%I',t,t);
   execute format('create policy "admin_all_%s" on public.%I for all using (public.is_admin()) with check (public.is_admin())',t,t);
 end loop;
end $$;

create policy "public_select_news" on public.news for select using (published=true);
create policy "public_select_programs" on public.programs for select using (published=true);
create policy "public_select_episodes" on public.episodes for select using (published=true);
create policy "public_select_history" on public.historical_64 for select using (published=true and active_in_october=true);
create policy "public_select_editorials" on public.editorials for select using (published=true);
create policy "public_select_members" on public.members for select using (published=true);
create policy "public_select_parishes" on public.parishes for select using (published=true);
create policy "public_select_advocations" on public.marian_advocations for select using (published=true);
create policy "public_select_diocese_info" on public.diocese_info for select using (true);
create policy "public_select_clergy" on public.clergy for select using (published=true);
create policy "public_select_live" on public.live_streams for select using (active=true);
create policy "public_select_settings" on public.site_settings for select using (true);
create policy "admin_select_admins" on public.admins for select using (auth.uid()=id);

insert into public.site_settings(id,site_name,organization_name,organization_url)
values(1,'Jóvenes Influencers del Señor','Jóvenes Influencers del Señor','https://influencersdelsenor.com')
on conflict(id) do nothing;

insert into public.diocese_info(id,history,description)
values(1,'','Diócesis de Ocaña')
on conflict(id) do nothing;

-- Storage: bucket público para imágenes/logos. Solo administradores pueden subir, editar y borrar.
insert into storage.buckets(id,name,public) values('media','media',true) on conflict(id) do update set public=true;
drop policy if exists "public read media" on storage.objects;
create policy "public read media" on storage.objects for select using (bucket_id='media');
drop policy if exists "admin insert media" on storage.objects;
create policy "admin insert media" on storage.objects for insert with check (bucket_id='media' and public.is_admin());
drop policy if exists "admin update media" on storage.objects;
create policy "admin update media" on storage.objects for update using (bucket_id='media' and public.is_admin()) with check (bucket_id='media' and public.is_admin());
drop policy if exists "admin delete media" on storage.objects;
create policy "admin delete media" on storage.objects for delete using (bucket_id='media' and public.is_admin());
