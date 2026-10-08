V35 - EDITORIALES CON AUTOR

El panel administrativo de Editorial ahora permite: nombre del autor, cargo del autor y foto del autor.
La foto se puede seleccionar desde el equipo y subir a Supabase Storage usando el bucket media existente.
La página pública de Editorial muestra la foto, nombre y cargo debajo de cada escrito.

Antes de usar los nuevos campos, ejecutar una sola vez:
supabase-editoriales-autor-foto-cargo.sql

Si el bucket media tiene RLS, debe permitir la operación de upload y la lectura necesaria; Supabase Storage controla estas operaciones mediante políticas RLS.
