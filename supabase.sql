create extension if not exists "pgcrypto";
create table if not exists admins(id uuid primary key references auth.users(id) on delete cascade,created_at timestamptz default now());
create table if not exists news(id uuid primary key default gen_random_uuid(),title text not null,summary text,content text,image_url text,video_url text,video_type text check(video_type in('youtube','facebook')),category text default 'Iglesia al Día',published boolean default false,published_at timestamptz,created_at timestamptz default now());
create table if not exists historical_data(id uuid primary key default gen_random_uuid(),number integer unique not null check(number between 1 and 64),title text not null,description text,image_url text,video_url text,video_type text check(video_type in('youtube','facebook')),published boolean default false,published_at timestamptz,active_from date default '2026-10-01',active_until date default '2026-11-01',created_at timestamptz default now());
create table if not exists parishes(id uuid primary key default gen_random_uuid(),name text not null,municipality text,address text,priest text,phone text,mass_schedule text,image_url text,created_at timestamptz default now());
create table if not exists team_members(id uuid primary key default gen_random_uuid(),name text not null,role text,bio text,image_url text,created_at timestamptz default now());
create table if not exists advocations(id uuid primary key default gen_random_uuid(),name text not null,history text,feast_date text,parish text,image_url text,created_at timestamptz default now());
create table if not exists editorials(id uuid primary key default gen_random_uuid(),title text not null,excerpt text,content text not null,author text,image_url text,published boolean default false,published_at timestamptz,created_at timestamptz default now());
create table if not exists programs(id uuid primary key default gen_random_uuid(),name text unique not null,slug text unique not null,description text,image_url text,published boolean default true,created_at timestamptz default now());
create table if not exists episodes(id uuid primary key default gen_random_uuid(),program_id uuid references programs(id) on delete cascade,title text not null,description text,video_url text,video_type text check(video_type in('youtube','facebook')),published boolean default false,published_at timestamptz,created_at timestamptz default now());

alter table admins enable row level security;alter table news enable row level security;alter table historical_data enable row level security;alter table parishes enable row level security;alter table team_members enable row level security;alter table advocations enable row level security;alter table editorials enable row level security;alter table programs enable row level security;alter table episodes enable row level security;

create or replace function public.is_admin() returns boolean language sql security definer set search_path=public stable as $$ select exists(select 1 from public.admins where id=auth.uid()); $$;

drop policy if exists "public published news" on news;create policy "public published news" on news for select to anon,authenticated using(published=true);
drop policy if exists "public historical october" on historical_data;create policy "public historical october" on historical_data for select to anon,authenticated using(published=true and current_date>=active_from and current_date<active_until);
drop policy if exists "public parishes" on parishes;create policy "public parishes" on parishes for select to anon,authenticated using(true);
drop policy if exists "public team" on team_members;create policy "public team" on team_members for select to anon,authenticated using(true);
drop policy if exists "public advocations" on advocations;create policy "public advocations" on advocations for select to anon,authenticated using(true);
drop policy if exists "public editorials" on editorials;create policy "public editorials" on editorials for select to anon,authenticated using(published=true);
drop policy if exists "public programs" on programs;create policy "public programs" on programs for select to anon,authenticated using(published=true);
drop policy if exists "public episodes" on episodes;create policy "public episodes" on episodes for select to anon,authenticated using(published=true);

drop policy if exists "admins manage news" on news;create policy "admins manage news" on news for all to authenticated using(public.is_admin()) with check(public.is_admin());
drop policy if exists "admins manage historical" on historical_data;create policy "admins manage historical" on historical_data for all to authenticated using(public.is_admin()) with check(public.is_admin());
drop policy if exists "admins manage parishes" on parishes;create policy "admins manage parishes" on parishes for all to authenticated using(public.is_admin()) with check(public.is_admin());
drop policy if exists "admins manage team" on team_members;create policy "admins manage team" on team_members for all to authenticated using(public.is_admin()) with check(public.is_admin());
drop policy if exists "admins manage advocations" on advocations;create policy "admins manage advocations" on advocations for all to authenticated using(public.is_admin()) with check(public.is_admin());
drop policy if exists "admins manage editorials" on editorials;create policy "admins manage editorials" on editorials for all to authenticated using(public.is_admin()) with check(public.is_admin());
drop policy if exists "admins manage programs" on programs;create policy "admins manage programs" on programs for all to authenticated using(public.is_admin()) with check(public.is_admin());
drop policy if exists "admins manage episodes" on episodes;create policy "admins manage episodes" on episodes for all to authenticated using(public.is_admin()) with check(public.is_admin());

insert into historical_data(number,title,active_from,active_until) select n,'Dato histórico #'||n,'2026-10-01','2026-11-01' from generate_series(1,64)n on conflict(number)do nothing;
