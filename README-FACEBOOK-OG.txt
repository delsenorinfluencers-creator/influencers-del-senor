V18 - VISTA PREVIA DE NOTICIAS PARA FACEBOOK

Al compartir una noticia con una URL como:
/iglesia-al-dia/noticia/con-el-papa-en-francia-cubrimiento-especial-jovenes-influencers-del-senor-iglesia-al-dia

Vercel la atiende mediante /api/noticia.js y genera HTML con Open Graph:
- og:title = título de la noticia
- og:description = resumen
- og:image = imagen de la noticia
- og:url = URL canónica
- og:site_name = Jóvenes Influencers del Señor
- article:published_time y article:section
- Twitter Card summary_large_image

IMPORTANTE:
1. Desplegar este ZIP en Vercel.
2. Si se usan variables de entorno, se pueden definir SUPABASE_URL y SUPABASE_PUBLISHABLE_KEY.
3. El código trae valores públicos de Supabase como respaldo para este proyecto.
4. Facebook puede conservar una vista previa antigua en caché. Después de publicar, usar el Sharing Debugger de Meta y solicitar una nueva extracción de la URL.
