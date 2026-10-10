-- 64 Datos Históricos: slug, resumen, contenido, imagen y video
alter table public.historical_64 add column if not exists slug text;
alter table public.historical_64 add column if not exists summary text;
alter table public.historical_64 add column if not exists content text;
alter table public.historical_64 add column if not exists image_url text;
alter table public.historical_64 add column if not exists video_url text;
alter table public.historical_64 add column if not exists number integer;
alter table public.historical_64 add column if not exists published boolean default false;

-- Crear slugs legibles para los registros existentes que todavía no tengan uno.
with missing as (
  select id, trim(both '-' from regexp_replace(lower(translate(coalesce(title,'dato-historico'), 'áéíóúüñÁÉÍÓÚÜÑ', 'aeiouunAEIOUUN')), '[^a-z0-9]+', '-', 'g')) || '-' || coalesce(number, row_number() over (order by created_at, id))::text as new_slug
  from public.historical_64 where slug is null or btrim(slug) = ''
)
update public.historical_64 h set slug = missing.new_slug from missing where h.id = missing.id;

create unique index if not exists historical_64_slug_unique on public.historical_64(slug) where slug is not null;
notify pgrst, 'reload schema';
