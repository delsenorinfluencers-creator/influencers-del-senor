JOVENES INFLUENCERS DEL SEÑOR — WEB MULTIPAGINA

Estructura:
/
/iglesia-al-dia/
/programas/
/programas/1/ ... /programas/11/
/en-vivo/
/64-datos/
/diocesis/
/editorial/
/quienes-somos/
/admin/

SUBIR A GITHUB:
Sube TODA la carpeta y conserva las carpetas. Deben quedar en la raíz del repositorio:
index.html
estilos.css
config.js
common.js
supabase.sql
iglesia-al-dia/index.html
programas/index.html
programas/1/index.html ... programas/11/index.html
en-vivo/index.html
64-datos/index.html
diocesis/index.html
editorial/index.html
quienes-somos/index.html
admin/index.html

VERCEL:
Importa el repositorio. Framework: Other. Build command: vacío. Output directory: vacío.

SUPABASE:
Ejecuta supabase.sql completo en SQL Editor. El script corrige el problema de la columna "published" agregándola si ya existían las tablas.

NOTA:
La clave usada es la publishable key de Supabase que proporcionaste. Para producción, el panel administrativo debe usar Supabase Auth y RLS; no pongas una service_role key en el navegador.


PANEL ADMINISTRATIVO — PASOS PARA QUE FUNCIONE
1. En Supabase entra a Authentication > Users > Add user.
2. Crea el correo y contraseña que usarás para el panel.
3. Copia el UUID de ese usuario.
4. En Supabase > SQL Editor ejecuta:
   insert into public.admins(id) values ('UUID_DEL_USUARIO');
5. Abre /admin/ en tu sitio Vercel.
6. Inicia sesión con el correo y contraseña creados.
7. Desde el panel podrás publicar Noticias, 64 Datos y Editoriales.

IMPORTANTE:
La publishable key puede estar en el navegador. NO uses service_role key en config.js.
El panel utiliza Supabase Auth + RLS.

IDENTIDAD VISUAL:
La web usa los colores tomados visualmente del logo: amarillo cálido, verde menta, verde oliva y café oscuro. El logo se incluye localmente como logo-influencers-del-senor.png.


SEÑAL EN VIVO FACEBOOK

Se agregó la tabla live_streams. Ejecuta el supabase.sql actualizado.
En /admin/, entra a 🔴 En Vivo, pega la URL del video Facebook Live y marca “Mostrar como EN VIVO”.
La señal aparecerá en /en-vivo/ y también en la página de inicio.
Para ocultarla, desmarca “Mostrar como EN VIVO”.
La URL debe ser la URL pública del VIDEO LIVE concreto de Facebook, no solamente la URL de la página.


MEJORAS VISUALES
- Identidad visual basada en el logo: verde oliva, verde menta, amarillo y café.
- Inicio renovado con portada, En Vivo, últimas noticias, especial 64 Datos y programas.
- Buscador en la barra superior.
- Noticias dinámicas desde Supabase.
- 64 Datos dinámicos desde Supabase.
- Reproductor Facebook Live dinámico en Inicio y En Vivo.
- Diseño responsive mejorado.


ACCESO AL PANEL
El menú superior ahora incluye el botón “🔐 Iniciar sesión”, que lleva a /admin/. En la portada también aparece el botón.


ACTUALIZACIÓN EN VIVO:
El panel /admin/ ahora permite configurar:
- M3U8/HLS
- Video MP4 en loop
- Facebook Live
- YouTube Live
- Activar/desactivar
- Mostrar en Inicio
- Prioridad

Ejecuta el supabase.sql completo para crear live_streams y sus políticas RLS.
Para M3U8 usa una URL pública accesible por HTTPS.
Para videos loop usa una URL directa a .mp4; el navegador puede bloquear autoplay con sonido, por eso inicia silenciado.


PANEL ADMINISTRATIVO COMPLETO
=============================
El panel /admin/ ahora administra:
- Dashboard y resumen
- Iglesia al Día (crear, editar, eliminar, publicar/ocultar, categorías y videos)
- Programas (11 programas iniciales, nombre, slug, descripción, logo, orden, visibilidad)
- Episodios/videos (programa, título, número, orden, YouTube, Facebook, MP4, imagen)
- En Vivo (M3U8/HLS, video loop, Facebook Live, YouTube Live, activar/desactivar, Inicio y /en-vivo/)
- 64 Datos (1-64, texto, imagen, video, publicación y activación en octubre)
- Diócesis (historia y datos)
- Parroquias
- Sacerdotes/información pastoral
- Advocaciones marianas
- Quiénes somos / Integrantes
- Editorial (autor, fecha, imagen, publicación)
- Configuración (logo, redes, WhatsApp, contacto y SEO)
- Carga de imágenes al bucket público "media" de Supabase Storage

MODELO DE DATOS
---------------
No se crean 11 tablas para los programas. Se usan:
programs  -> los programas
episodes  -> los videos/episodios relacionados con cada programa

IMPORTANTE
----------
1. Ejecuta el supabase.sql completo en Supabase SQL Editor.
2. En Supabase Authentication crea el usuario administrador.
3. Copia su UUID y ejecuta:
   INSERT INTO public.admins(id) VALUES ('UUID_DEL_USUARIO');
4. Sube todo el contenido del ZIP a GitHub, manteniendo las carpetas.
5. En Vercel conserva las variables NEXT_PUBLIC_SUPABASE_URL y NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY.
