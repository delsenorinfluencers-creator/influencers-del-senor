-- REPARACIÓN DEL PANEL: PUBLICIDAD + CONFIGURACIÓN
-- Ejecutar completo en Supabase > SQL Editor.

create extension if not exists pgcrypto;

create table if not exists public.banners (
  id uuid primary key default gen_random_uuid(),
  image_url text not null,
  duration_seconds integer not null default 5,
  created_at timestamptz not null default now()
);

create table if not exists public.site_settings (
  key text primary key,
  value text not null default '',
  updated_at timestamptz not null default now()
);

insert into public.site_settings(key,value) values
('site_name','Jóvenes Influencers del Señor'),
('footer_text','Comunicación al servicio de Dios.'),
('created_by','Gamarra TV'),
('show_ads','1'),
('site_logo','')
on conflict (key) do nothing;

-- RLS: permite lectura pública de banners/configuración y escritura únicamente al administrador.
alter table public.banners enable row level security;
alter table public.site_settings enable row level security;

drop policy if exists "banners_public_read" on public.banners;
create policy "banners_public_read" on public.banners for select using (true);

drop policy if exists "banners_admin_insert" on public.banners;
create policy "banners_admin_insert" on public.banners for insert to authenticated
with check (exists(select 1 from public.admins a where a.id=auth.uid()));

drop policy if exists "banners_admin_delete" on public.banners;
create policy "banners_admin_delete" on public.banners for delete to authenticated
using (exists(select 1 from public.admins a where a.id=auth.uid()));

drop policy if exists "settings_public_read" on public.site_settings;
create policy "settings_public_read" on public.site_settings for select using (true);

drop policy if exists "settings_admin_insert" on public.site_settings;
create policy "settings_admin_insert" on public.site_settings for insert to authenticated
with check (exists(select 1 from public.admins a where a.id=auth.uid()));

drop policy if exists "settings_admin_update" on public.site_settings;
create policy "settings_admin_update" on public.site_settings for update to authenticated
using (exists(select 1 from public.admins a where a.id=auth.uid()))
with check (exists(select 1 from public.admins a where a.id=auth.uid()));

-- IMPORTANTE:
-- Este panel ya no intenta escribir true/false en columnas integer de una tabla antigua.
-- La configuración usa site_settings.value como texto y guarda show_ads como '1' o '0'.
