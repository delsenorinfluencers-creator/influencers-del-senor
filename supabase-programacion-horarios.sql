-- HORARIOS DE PROGRAMACIÓN
-- Ejecutar UNA VEZ en Supabase > SQL Editor.
-- Compatible con la tabla public.programs existente.

alter table public.programs add column if not exists days_of_week text default '1,2,3,4,5';
alter table public.programs add column if not exists start_time text;
alter table public.programs add column if not exists end_time text;

notify pgrst, 'reload schema';
