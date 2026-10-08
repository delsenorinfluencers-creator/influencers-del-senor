V38 - URL AMIGABLE PARA EDITORIALES

Las editoriales ahora usan URLs públicas como:
https://www.influencersdelsenor.com/editoriales/editorial/nombre-de-la-editorial

El servidor Vercel reescribe esa URL a /api/editorial?slug=... para generar la página completa, con portada, título, fecha, contenido, autor, cargo y foto del autor.

El panel genera automáticamente el slug de nuevas editoriales a partir del título.

Ejecutar una sola vez: supabase-editoriales-url-amigable.sql
