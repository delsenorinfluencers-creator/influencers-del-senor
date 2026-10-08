-- Editoriales: campos necesarios para portada, autor y subpágina completa.
ALTER TABLE public.editorials ADD COLUMN IF NOT EXISTS slug text;
ALTER TABLE public.editorials ADD COLUMN IF NOT EXISTS author_name text;
ALTER TABLE public.editorials ADD COLUMN IF NOT EXISTS author_position text;
ALTER TABLE public.editorials ADD COLUMN IF NOT EXISTS author_photo_url text;
ALTER TABLE public.editorials ADD COLUMN IF NOT EXISTS image_url text;
