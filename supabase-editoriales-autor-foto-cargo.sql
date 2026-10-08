-- Editoriales: foto y cargo del autor
-- No borra datos existentes. Ejecutar una sola vez en Supabase SQL Editor.

ALTER TABLE public.editorials
  ADD COLUMN IF NOT EXISTS author_position text;

ALTER TABLE public.editorials
  ADD COLUMN IF NOT EXISTS author_photo_url text;

-- Comprobación
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'editorials'
  AND column_name IN ('author_name','author_position','author_photo_url','slug')
ORDER BY column_name;
