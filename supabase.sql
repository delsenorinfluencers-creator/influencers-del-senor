
create extension if not exists pgcrypto;

create table if not exists public.news(id uuid primary key default gen_random_uuid(),title text not null,excerpt text,content text,image_url text,youtube_url text,facebook_url text,published_at timestamptz default now());
create table if not exists public.historical_64(id uuid primary key default gen_random_uuid(),number integer unique not null check(number between 1 and 64),title text not null,content text,youtube_url text,facebook_url text);
create table if not exists public.editorials(id uuid primary key default gen_random_uuid(),title text not null,excerpt text,content text,image_url text,published_at timestamptz default now());
create table if not exists public.members(id uuid primary key default gen_random_uuid(),name text not null,role text,photo_url text,bio text);
create table if not exists public.parishes(id uuid primary key default gen_random_uuid(),name text not null,municipality text,address text,image_url text,description text);
create table if not exists public.marian_advocations(id uuid primary key default gen_random_uuid(),name text not null,description text,image_url text);
create table if not exists public.admins(id uuid primary key references auth.users(id) on delete cascade);

alter table public.news add column if not exists published boolean default true;
alter table public.historical_64 add column if not exists published boolean default true;
alter table public.editorials add column if not exists published boolean default true;
alter table public.members add column if not exists published boolean default true;
alter table public.parishes add column if not exists published boolean default true;
alter table public.marian_advocations add column if not exists published boolean default true;

update public.news set published=true where published is null;
update public.historical_64 set published=true where published is null;
update public.editorials set published=true where published is null;
update public.members set published=true where published is null;
update public.parishes set published=true where published is null;
update public.marian_advocations set published=true where published is null;

alter table public.news enable row level security;
alter table public.historical_64 enable row level security;
alter table public.editorials enable row level security;
alter table public.members enable row level security;
alter table public.parishes enable row level security;
alter table public.marian_advocations enable row level security;
alter table public.admins enable row level security;

create or replace function public.is_admin() returns boolean language sql security definer set search_path=public as $$ select exists(select 1 from public.admins where id=auth.uid()); $$;

drop policy if exists "public news" on public.news;
create policy "public news" on public.news for select using (published=true);
drop policy if exists "public history" on public.historical_64;
create policy "public history" on public.historical_64 for select using (published=true);
drop policy if exists "public editorial" on public.editorials;
create policy "public editorial" on public.editorials for select using (published=true);
drop policy if exists "public members" on public.members;
create policy "public members" on public.members for select using (published=true);
drop policy if exists "public parishes" on public.parishes;
create policy "public parishes" on public.parishes for select using (published=true);
drop policy if exists "public advocations" on public.marian_advocations;
create policy "public advocations" on public.marian_advocations for select using (published=true);

drop policy if exists "admin news" on public.news;
create policy "admin news" on public.news for all using (public.is_admin()) with check (public.is_admin());
drop policy if exists "admin history" on public.historical_64;
create policy "admin history" on public.historical_64 for all using (public.is_admin()) with check (public.is_admin());
drop policy if exists "admin editorial" on public.editorials;
create policy "admin editorial" on public.editorials for all using (public.is_admin()) with check (public.is_admin());
drop policy if exists "admin members" on public.members;
create policy "admin members" on public.members for all using (public.is_admin()) with check (public.is_admin());
drop policy if exists "admin parishes" on public.parishes;
create policy "admin parishes" on public.parishes for all using (public.is_admin()) with check (public.is_admin());
drop policy if exists "admin advocations" on public.marian_advocations;
create policy "admin advocations" on public.marian_advocations for all using (public.is_admin()) with check (public.is_admin());
drop policy if exists "admin self" on public.admins;
create policy "admin self" on public.admins for select using (auth.uid()=id);
