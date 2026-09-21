create extension if not exists pgcrypto;

create table if not exists public.admins (
  id uuid primary key references auth.users(id) on delete cascade,
  created_at timestamptz default now()
);

create table if not exists public.news (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  excerpt text,
  content text,
  image_url text,
  youtube_url text,
  facebook_url text,
  published_at timestamptz default now(),
  published boolean default true,
  created_at timestamptz default now()
);

create table if not exists public.historical_64 (
  id uuid primary key default gen_random_uuid(),
  number integer unique not null check (number between 1 and 64),
  title text not null,
  content text,
  youtube_url text,
  facebook_url text,
  published boolean default true,
  created_at timestamptz default now()
);

create table if not exists public.editorials (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  excerpt text,
  content text,
  image_url text,
  published_at timestamptz default now(),
  published boolean default true,
  created_at timestamptz default now()
);

create table if not exists public.members (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  role text,
  photo_url text,
  bio text,
  published boolean default true
);

create table if not exists public.parishes (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  municipality text,
  address text,
  image_url text,
  description text,
  published boolean default true
);

create table if not exists public.marian_advocations (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text,
  image_url text,
  published boolean default true
);

alter table public.news enable row level security;
alter table public.historical_64 enable row level security;
alter table public.editorials enable row level security;
alter table public.members enable row level security;
alter table public.parishes enable row level security;
alter table public.marian_advocations enable row level security;
alter table public.admins enable row level security;

drop policy if exists "Public read published news" on public.news;
create policy "Public read published news" on public.news for select using (published = true);

drop policy if exists "Public read historical" on public.historical_64;
create policy "Public read historical" on public.historical_64 for select using (published = true);

drop policy if exists "Public read editorials" on public.editorials;
create policy "Public read editorials" on public.editorials for select using (published = true);

drop policy if exists "Public read members" on public.members;
create policy "Public read members" on public.members for select using (published = true);

drop policy if exists "Public read parishes" on public.parishes;
create policy "Public read parishes" on public.parishes for select using (published = true);

drop policy if exists "Public read advocations" on public.marian_advocations;
create policy "Public read advocations" on public.marian_advocations for select using (published = true);

create or replace function public.is_admin()
returns boolean language sql security definer set search_path = public
as $$ select exists(select 1 from public.admins where id = auth.uid()); $$;

drop policy if exists "Admins manage news" on public.news;
create policy "Admins manage news" on public.news for all using (public.is_admin()) with check (public.is_admin());

drop policy if exists "Admins manage historical" on public.historical_64;
create policy "Admins manage historical" on public.historical_64 for all using (public.is_admin()) with check (public.is_admin());

drop policy if exists "Admins manage editorials" on public.editorials;
create policy "Admins manage editorials" on public.editorials for all using (public.is_admin()) with check (public.is_admin());

drop policy if exists "Admins manage members" on public.members;
create policy "Admins manage members" on public.members for all using (public.is_admin()) with check (public.is_admin());

drop policy if exists "Admins manage parishes" on public.parishes;
create policy "Admins manage parishes" on public.parishes for all using (public.is_admin()) with check (public.is_admin());

drop policy if exists "Admins manage advocations" on public.marian_advocations;
create policy "Admins manage advocations" on public.marian_advocations for all using (public.is_admin()) with check (public.is_admin());

drop policy if exists "Admin can read admins" on public.admins;
create policy "Admin can read admins" on public.admins for select using (auth.uid() = id);

-- Después de crear el usuario en Authentication > Users:
-- insert into public.admins(id) values ('UUID-DEL-USUARIO');
