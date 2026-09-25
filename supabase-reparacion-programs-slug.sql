-- REPARACIÓN DEFINITIVA DEL SLUG DE PROGRAMAS
-- Ejecutar UNA VEZ en Supabase > SQL Editor.
-- Corrige programas existentes con slug NULL y evita nuevos registros sin slug.

alter table public.programs add column if not exists slug text;

-- Genera un slug único para los programas que todavía no lo tienen.
update public.programs
set slug = lower(
  trim(both '-' from regexp_replace(coalesce(nullif(name,''),'programa'), '[^a-zA-Z0-9]+', '-', 'g'))
) || '-' || left(replace(id::text,'-',''),8)
where slug is null or btrim(slug) = '';

-- Si existe algún slug vacío después de la limpieza, usa el UUID como respaldo.
update public.programs
set slug = 'programa-' || left(replace(id::text,'-',''),12)
where slug is null or btrim(slug) = '';

-- Asegura que los futuros programas no puedan quedar sin slug.
alter table public.programs alter column slug set not null;

-- El índice único permite URLs/identificadores sin duplicados.
create unique index if not exists programs_slug_unique_idx
on public.programs(slug);

-- Verificación opcional:
-- select id,name,slug from public.programs order by sort_order, name;
