-- ============================================================
-- Jóvenes Influencers del Señor - esquema completo Supabase
-- Ejecutar en Supabase > SQL Editor.
-- IMPORTANTE: antes de ejecutar la sección BOOTSTRAP cambia
-- YOUR_ADMIN_UUID por el UUID real de Authentication > Users.
-- ============================================================

create extension if not exists pgcrypto;

-- ---------- ADMINISTRADORES ----------
create table if not exists public.admins (
  id uuid primary key references auth.users(id) on delete cascade,
  email text,
  role text not null default 'admin',
  active boolean not null default true,
  created_at timestamptz not null default now()
);
alter table public.admins add column if not exists email text;
alter table public.admins add column if not exists role text default 'admin';
alter table public.admins add column if not exists active boolean default true;
alter table public.admins add column if not exists created_at timestamptz default now();

-- ---------- NOTICIAS ----------
create table if not exists public.news (
 id uuid primary key default gen_random_uuid(), title text not null, slug text,
 summary text, content text, category text, image_url text, youtube_url text,
 facebook_url text, published boolean default false, published_at timestamptz,
 created_at timestamptz default now(), updated_at timestamptz default now()
);
alter table public.news add column if not exists slug text;
alter table public.news add column if not exists summary text;
alter table public.news add column if not exists content text;
alter table public.news add column if not exists category text;
alter table public.news add column if not exists image_url text;
alter table public.news add column if not exists youtube_url text;
alter table public.news add column if not exists facebook_url text;
alter table public.news add column if not exists published boolean default false;
alter table public.news add column if not exists published_at timestamptz;
alter table public.news add column if not exists created_at timestamptz default now();
alter table public.news add column if not exists updated_at timestamptz default now();

-- ---------- PROGRAMAS ----------
create table if not exists public.programs (
 id uuid primary key default gen_random_uuid(), name text not null, slug text unique,
 description text, image_url text, sort_order integer default 0,
 visible boolean default true, created_at timestamptz default now(), updated_at timestamptz default now()
);
alter table public.programs add column if not exists slug text;
alter table public.programs add column if not exists description text;
alter table public.programs add column if not exists image_url text;
alter table public.programs add column if not exists sort_order integer default 0;
alter table public.programs add column if not exists visible boolean default true;
alter table public.programs add column if not exists created_at timestamptz default now();
alter table public.programs add column if not exists updated_at timestamptz default now();

-- ---------- EPISODIOS ----------
create table if not exists public.episodes (
 id uuid primary key default gen_random_uuid(), program_id uuid references public.programs(id) on delete cascade,
 title text not null, description text, image_url text, youtube_url text, facebook_url text,
 sort_order integer default 0, published boolean default false, published_at timestamptz,
 created_at timestamptz default now(), updated_at timestamptz default now()
);
alter table public.episodes add column if not exists program_id uuid;
alter table public.episodes add column if not exists description text;
alter table public.episodes add column if not exists image_url text;
alter table public.episodes add column if not exists youtube_url text;
alter table public.episodes add column if not exists facebook_url text;
alter table public.episodes add column if not exists sort_order integer default 0;
alter table public.episodes add column if not exists published boolean default false;
alter table public.episodes add column if not exists published_at timestamptz;
alter table public.episodes add column if not exists created_at timestamptz default now();
alter table public.episodes add column if not exists updated_at timestamptz default now();

-- ---------- EN VIVO ----------
create table if not exists public.live_streams (
 id uuid primary key default gen_random_uuid(), title text, type text default 'm3u8',
 url text, loop_url text, image_url text, description text, active boolean default false,
 show_live boolean default true, created_at timestamptz default now(), updated_at timestamptz default now()
);
alter table public.live_streams add column if not exists title text;
alter table public.live_streams add column if not exists type text default 'm3u8';
alter table public.live_streams add column if not exists url text;
alter table public.live_streams add column if not exists loop_url text;
alter table public.live_streams add column if not exists image_url text;
alter table public.live_streams add column if not exists description text;
alter table public.live_streams add column if not exists active boolean default false;
alter table public.live_streams add column if not exists show_live boolean default true;
alter table public.live_streams add column if not exists created_at timestamptz default now();
alter table public.live_streams add column if not exists updated_at timestamptz default now();

-- ---------- 64 DATOS ----------
create table if not exists public.historical_64 (
 id uuid primary key default gen_random_uuid(), number integer unique, title text not null,
 content text, image_url text, video_url text, published boolean default false,
 available_from date, available_until date, created_at timestamptz default now(), updated_at timestamptz default now()
);
alter table public.historical_64 add column if not exists number integer;
alter table public.historical_64 add column if not exists content text;
alter table public.historical_64 add column if not exists image_url text;
alter table public.historical_64 add column if not exists video_url text;
alter table public.historical_64 add column if not exists published boolean default false;
alter table public.historical_64 add column if not exists available_from date;
alter table public.historical_64 add column if not exists available_until date;
alter table public.historical_64 add column if not exists created_at timestamptz default now();
alter table public.historical_64 add column if not exists updated_at timestamptz default now();

-- ---------- DIÓCESIS ----------
create table if not exists public.diocese_sections (
 id uuid primary key default gen_random_uuid(), title text not null, content text,
 image_url text, sort_order integer default 0, published boolean default false, created_at timestamptz default now(), updated_at timestamptz default now()
);
alter table public.diocese_sections add column if not exists content text;
alter table public.diocese_sections add column if not exists image_url text;
alter table public.diocese_sections add column if not exists sort_order integer default 0;
alter table public.diocese_sections add column if not exists published boolean default false;

-- ---------- INTEGRANTES ----------
create table if not exists public.team_members (
 id uuid primary key default gen_random_uuid(), name text not null, role text, bio text,
 image_url text, social_url text, sort_order integer default 0, published boolean default false,
 created_at timestamptz default now(), updated_at timestamptz default now()
);

-- ---------- EDITORIAL ----------
create table if not exists public.editorials (
 id uuid primary key default gen_random_uuid(), title text not null, author text, content text,
 image_url text, published boolean default false, published_at timestamptz,
 created_at timestamptz default now(), updated_at timestamptz default now()
);

-- ---------- CONFIGURACIÓN ----------
create table if not exists public.site_settings (
 id integer primary key default 1, site_name text, description text, logo_url text,
 logo64_url text, facebook_url text, youtube_url text, whatsapp text,
 updated_at timestamptz default now()
);
insert into public.site_settings(id,site_name,description,logo_url,logo64_url,facebook_url)
values(1,'Jóvenes Influencers del Señor','Comunicación al servicio de Dios.','https://i.ibb.co/tw6GTfyV/Dise-o-sin-t-tulo-12.png','https://i.ibb.co/HfhqmYQs/file-000000006d4c81f5b9452f237ee19824.png','https://www.facebook.com/jovenesinfluencersdelsenor')
on conflict(id) do nothing;

-- ---------- LOS 11 PROGRAMAS ----------
insert into public.programs(name,slug,description,sort_order,visible) values
('Un café con aroma de fe','un-cafe-con-aroma-de-fe','Un espacio para conversar sobre la fe y la vida.',1,true),
('El Podcast','el-podcast','Conversaciones y contenidos de evangelización.',2,true),
('El Youcat te conecta','el-youcat-te-conecta','La fe explicada para jóvenes.',3,true),
('La voz líder','la-voz-lider','Historias, liderazgo y servicio.',4,true),
('Hagan lo que Él les diga','hagan-lo-que-el-les-diga','Reflexiones desde el Evangelio.',5,true),
('Una palabra en 60 segundos','una-palabra-en-60-segundos','Un mensaje breve para cada día.',6,true),
('Fe y vida diaria','fe-y-vida-diaria','La fe llevada a las situaciones cotidianas.',7,true),
('La Santa Misa','la-santa-misa','Celebraciones y transmisiones eucarísticas.',8,true),
('Kerigma en fuego','kerigma-en-fuego','Anuncio y misión evangelizadora.',9,true),
('Semilla vocacional','semilla-vocacional','Contenido sobre vocación y discernimiento.',10,true),
('Cultiva la fe','cultiva-la-fe','Formación y crecimiento espiritual.',11,true)
on conflict(slug) do update set name=excluded.name,sort_order=excluded.sort_order;

-- ---------- FUNCIONES Y RLS ----------
create or replace function public.is_admin(uid uuid default auth.uid()) returns boolean
language plpgsql security definer set search_path=public stable as $$
begin
 return exists(select 1 from public.admins where id=uid and active=true and role='admin');
end; $$;
revoke all on function public.is_admin(uuid) from public;
grant execute on function public.is_admin(uuid) to authenticated;

alter table public.admins enable row level security;
alter table public.news enable row level security;
alter table public.programs enable row level security;
alter table public.episodes enable row level security;
alter table public.live_streams enable row level security;
alter table public.historical_64 enable row level security;
alter table public.diocese_sections enable row level security;
alter table public.team_members enable row level security;
alter table public.editorials enable row level security;
alter table public.site_settings enable row level security;

-- Políticas públicas de lectura para contenido publicado.
do $$ begin
 execute 'drop policy if exists news_public_read on public.news';
 execute 'create policy news_public_read on public.news for select using (published=true or public.is_admin())';
 execute 'drop policy if exists programs_public_read on public.programs';
 execute 'create policy programs_public_read on public.programs for select using (visible=true or public.is_admin())';
 execute 'drop policy if exists episodes_public_read on public.episodes';
 execute 'create policy episodes_public_read on public.episodes for select using (published=true or public.is_admin())';
 execute 'drop policy if exists live_public_read on public.live_streams';
 execute 'create policy live_public_read on public.live_streams for select using ((active=true and show_live=true) or public.is_admin())';
 execute 'drop policy if exists data_public_read on public.historical_64';
 execute 'create policy data_public_read on public.historical_64 for select using (published=true or public.is_admin())';
 execute 'drop policy if exists diocese_public_read on public.diocese_sections';
 execute 'create policy diocese_public_read on public.diocese_sections for select using (published=true or public.is_admin())';
 execute 'drop policy if exists team_public_read on public.team_members';
 execute 'create policy team_public_read on public.team_members for select using (published=true or public.is_admin())';
 execute 'drop policy if exists editorial_public_read on public.editorials';
 execute 'create policy editorial_public_read on public.editorials for select using (published=true or public.is_admin())';
 execute 'drop policy if exists settings_public_read on public.site_settings';
 execute 'create policy settings_public_read on public.site_settings for select using (true)';
end $$;

-- Los administradores pueden gestionar el contenido.
do $$ declare t text; begin
 foreach t in array array['news','programs','episodes','live_streams','historical_64','diocese_sections','team_members','editorials','site_settings'] loop
  execute format('drop policy if exists %I_admin_all on public.%I',t,t);
  execute format('create policy %I_admin_all on public.%I for all to authenticated using (public.is_admin()) with check (public.is_admin())',t,t);
 end loop;
end $$;

-- Un usuario autenticado puede consultar su propia fila de admins.
do $$ begin
 execute 'drop policy if exists admins_self_read on public.admins';
 execute 'create policy admins_self_read on public.admins for select to authenticated using (id=auth.uid() or public.is_admin())';
 execute 'drop policy if exists admins_admin_write on public.admins';
 execute 'create policy admins_admin_write on public.admins for all to authenticated using (public.is_admin()) with check (public.is_admin())';
end $$;

-- ---------- STORAGE ----------
insert into storage.buckets(id,name,public) values('media','media',true) on conflict(id) do update set public=true;
do $$ begin
 execute 'drop policy if exists media_public_read on storage.objects';
 execute 'create policy media_public_read on storage.objects for select using (bucket_id=''media'')';
 execute 'drop policy if exists media_admin_insert on storage.objects';
 execute 'create policy media_admin_insert on storage.objects for insert to authenticated with check (bucket_id=''media'' and public.is_admin())';
 execute 'drop policy if exists media_admin_update on storage.objects';
 execute 'create policy media_admin_update on storage.objects for update to authenticated using (bucket_id=''media'' and public.is_admin()) with check (bucket_id=''media'' and public.is_admin())';
 execute 'drop policy if exists media_admin_delete on storage.objects';
 execute 'create policy media_admin_delete on storage.objects for delete to authenticated using (bucket_id=''media'' and public.is_admin())';
end $$;

-- ============================================================
-- BOOTSTRAP DEL PRIMER ADMINISTRADOR
-- 1. En Supabase > Authentication > Users copia el UUID.
-- 2. Sustituye YOUR_ADMIN_UUID abajo por ese UUID.
-- 3. Ejecuta solamente esta sentencia.
-- ============================================================
-- insert into public.admins(id,email,role,active)
-- select id,email,'admin',true from auth.users
-- where id='YOUR_ADMIN_UUID'::uuid
-- on conflict(id) do update set email=excluded.email,role='admin',active=true;

-- Refrescar el caché de PostgREST después de ejecutar el SQL.
notify pgrst, 'reload schema';
