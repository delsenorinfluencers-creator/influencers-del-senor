-- Programación editable desde el panel administrativo
-- Ejecutar UNA sola vez en Supabase SQL Editor. Es compatible con la tabla programs existente.
alter table public.programs add column if not exists days_of_week text default '1,2,3,4,5';
alter table public.programs add column if not exists start_time text;
alter table public.programs add column if not exists end_time text;

-- Ejemplo opcional: horarios de lunes a viernes para los programas existentes.
-- Los valores se pueden cambiar desde el panel y no son obligatorios.

-- Refresca la caché de PostgREST después de ejecutar el SQL.
notify pgrst, 'reload schema';
