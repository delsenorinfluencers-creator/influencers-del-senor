V22 - CORRECCIÓN DEL ERROR DE PROGRAMAS

Error corregido:
null value in column "slug" of relation "programs" violates not-null constraint

CAMBIOS:
- El panel genera automáticamente el slug al escribir el nombre del programa.
- El campo Slug queda automático para no tener que escribirlo manualmente.
- Al guardar, el panel vuelve a generar el slug y comprueba si ya existe.
- Si el slug ya existe, agrega -2, -3, etc. hasta encontrar uno libre.
- Si el nombre no produce un slug válido, genera uno de respaldo.
- Se incluye SQL para reparar programas antiguos que tengan slug NULL.

IMPORTANTE:
Ejecuta UNA VEZ:
supabase-reparacion-programs-slug.sql

Luego reemplaza los archivos del sitio con esta versión V22.
