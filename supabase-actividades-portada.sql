-- ACTIVIDADES DESTACADAS EN PORTADA
-- Ejecutar UNA VEZ en Supabase > SQL Editor.

create table if not exists public.homepage_activities(
 id uuid primary key default gen_random_uuid(),
 title text not null,
 description text,
 image_url text,
 link_url text,
 button_text text default 'Ver actividad',
 activity_date text,
 sort_order integer default 0,
 active boolean default true,
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now()
);

alter table public.homepage_activities add column if not exists description text;
alter table public.homepage_activities add column if not exists image_url text;
alter table public.homepage_activities add column if not exists link_url text;
alter table public.homepage_activities add column if not exists button_text text default 'Ver actividad';
alter table public.homepage_activities add column if not exists activity_date text;
alter table public.homepage_activities add column if not exists sort_order integer default 0;
alter table public.homepage_activities add column if not exists active boolean default true;
alter table public.homepage_activities add column if not exists created_at timestamptz default now();
alter table public.homepage_activities add column if not exists updated_at timestamptz default now();

alter table public.homepage_activities enable row level security;

drop policy if exists homepage_activities_public_read on public.homepage_activities;
create policy homepage_activities_public_read on public.homepage_activities
for select to anon, authenticated using (active = true);

drop policy if exists homepage_activities_admin_write on public.homepage_activities;
create policy homepage_activities_admin_write on public.homepage_activities
for all to authenticated using (public.is_admin()) with check (public.is_admin());

create index if not exists homepage_activities_active_sort_idx
on public.homepage_activities(active, sort_order, created_at desc);
