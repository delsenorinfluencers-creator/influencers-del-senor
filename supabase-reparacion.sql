-- REPARACIÓN SEGURA DEL PANEL ADMINISTRATIVO
-- No elimina tablas ni cambia tipos existentes.

alter table public.editorials add column if not exists created_at timestamptz;
alter table public.editorials add column if not exists updated_at timestamptz;
update public.editorials set created_at=coalesce(created_at,now()) where created_at is null;
update public.editorials set updated_at=coalesce(updated_at,now()) where updated_at is null;

alter table public.live_streams add column if not exists image_url text;
alter table public.live_streams add column if not exists loop_url text;
alter table public.live_streams add column if not exists show_live boolean default false;
alter table public.live_streams add column if not exists type text;
alter table public.live_streams add column if not exists url text;
alter table public.live_streams add column if not exists title text;

alter table public.programs add column if not exists sort_order integer;

alter table public.news add column if not exists created_at timestamptz;
alter table public.news add column if not exists updated_at timestamptz;
alter table public.programs add column if not exists created_at timestamptz;
alter table public.programs add column if not exists updated_at timestamptz;
alter table public.episodes add column if not exists created_at timestamptz;
alter table public.episodes add column if not exists updated_at timestamptz;
alter table public.historical_64 add column if not exists created_at timestamptz;
alter table public.historical_64 add column if not exists updated_at timestamptz;

-- NO convertir published/active a boolean.
-- El panel nuevo no envía true a columnas INTEGER.

select table_name,column_name,data_type,udt_name
from information_schema.columns
where table_schema='public'
and table_name in ('admins','news','programs','episodes','live_streams','historical_64','diocese','parishes','team_members','editorials','site_settings')
order by table_name,ordinal_position;


-- Slug automático para noticias
alter table if exists public.news add column if not exists slug text;

-- Genera el slug automáticamente cuando se inserta o modifica el título de una noticia.
create or replace function public.generate_news_slug() returns trigger
language plpgsql as $$
begin
  if new.title is not null then
    new.slug := lower(trim(regexp_replace(translate(new.title, 'áéíóúÁÉÍÓÚñÑüÜ', 'aeiouAEIOUnNuU'), '[^a-zA-Z0-9]+', '-', 'g')));
    new.slug := trim(both '-' from new.slug);
  end if;
  return new;
end;
$$;

drop trigger if exists news_generate_slug on public.news;
create trigger news_generate_slug
before insert or update of title on public.news
for each row execute function public.generate_news_slug();


-- Google Drive loop:
-- El panel convierte automáticamente:
-- https://drive.google.com/file/d/FILE_ID/view?usp=drive_link
-- en:
-- https://drive.google.com/uc?export=download&id=FILE_ID
-- No hace falta almacenar una segunda columna.


-- SUPABASE STORAGE PARA IMÁGENES DE EN VIVO
-- Si el bucket ya existe, no se recrea.
insert into storage.buckets (id, name, public)
values ('live-images', 'live-images', true)
on conflict (id) do update set public = true;

drop policy if exists "live-images public read" on storage.objects;
create policy "live-images public read"
on storage.objects for select
using (bucket_id = 'live-images');

drop policy if exists "live-images authenticated upload" on storage.objects;
create policy "live-images authenticated upload"
on storage.objects for insert
to authenticated
with check (bucket_id = 'live-images');

drop policy if exists "live-images authenticated update" on storage.objects;
create policy "live-images authenticated update"
on storage.objects for update
to authenticated
using (bucket_id = 'live-images')
with check (bucket_id = 'live-images');

drop policy if exists "live-images authenticated delete" on storage.objects;
create policy "live-images authenticated delete"
on storage.objects for delete
to authenticated
using (bucket_id = 'live-images');
