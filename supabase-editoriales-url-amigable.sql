ALTER TABLE public.editorials ADD COLUMN IF NOT EXISTS slug text;
ALTER TABLE public.editorials ADD COLUMN IF NOT EXISTS author_name text;
ALTER TABLE public.editorials ADD COLUMN IF NOT EXISTS author_position text;
ALTER TABLE public.editorials ADD COLUMN IF NOT EXISTS author_photo_url text;
ALTER TABLE public.editorials ADD COLUMN IF NOT EXISTS image_url text;

-- Si hay editoriales antiguas sin slug, ejecuta este bloque después de comprobar que slugify no genere duplicados.
-- El panel nuevo genera automáticamente el slug de las nuevas editoriales.
