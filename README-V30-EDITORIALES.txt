V30 - CORRECCIÓN EDITORIALES

Error corregido:
Could not find the author_name column of editorials in the schema cache.

Ejecuta una vez el archivo:
supabase-fix-editorials-author-name.sql

No elimina la columna author existente ni borra datos. Si existe author, copia sus valores a author_name.
Después recarga el panel administrativo.
