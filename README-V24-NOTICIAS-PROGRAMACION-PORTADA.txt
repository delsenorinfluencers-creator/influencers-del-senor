V24 - CORRECCIÓN DEFINITIVA DE PORTADA

CORREGIDO:
1. Las noticias publicadas de Supabase ahora aparecen en la portada.
2. La consulta de noticias usa published=true.
3. Se muestran hasta 6 noticias ordenadas por published_at descendente.
4. La programación de portada ahora consulta public.programs con published=true.
5. La programación filtra automáticamente el día actual usando days_of_week.
6. Se muestran imagen, hora de inicio/fin y nombre del programa.
7. La señal en vivo permanece automática con SSH101.
8. También se actualizó la versión SPA app.js para evitar que la programación vuelva a quedar vacía.

NO ES NECESARIO EJECUTAR SQL NUEVO para estos dos cambios si ya ejecutaste los SQL anteriores de programs.

IMPORTANTE:
Después de reemplazar los archivos, limpia caché del navegador con Ctrl+F5.
