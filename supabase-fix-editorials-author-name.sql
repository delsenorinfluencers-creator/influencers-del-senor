-- CORRECCIÓN EDITORIALES: author_name
-- Ejecutar UNA sola vez en Supabase > SQL Editor.

alter table public.editorials
  add column if not exists author_name text;

-- Conserva los autores existentes si tu tabla anterior usaba la columna "author".
do $$
begin
  if exists (
    select 1 from information_schema.columns
    where table_schema = ''public''
      and table_name = ''editorials''
      and column_name = ''author''
  ) then
    execute ''update public.editorials set author_name = coalesce(author_name, author) where author_name is null'';
  end if;
end $$;

notify pgrst, ''reload schema'';
