PAQUETE REPARADO - JÓVENES INFLUENCERS DEL SEÑOR

1. Sube/reemplaza admin/panel.html.
2. Reemplaza config.js.
3. Ejecuta supabase-reparacion.sql en Supabase SQL Editor.
4. Mantén el UUID del administrador en public.admins.
5. Abre /admin/index.html e inicia sesión.

CORRECCIONES:
- config.js usa SUPABASE_PUBLISHABLE_KEY, que es el nombre que tienes realmente.
- Ya no se exige admins.email, admins.role ni admins.active.
- Ya no se consulta programs.sort_order antes de existir.
- Editorial ya no falla si created_at no existe.
- El panel no hace comparaciones booleanas sobre columnas INTEGER.
- live_streams recibe las columnas opcionales que faltaban.
- Las secciones del panel ya cargan datos reales de Supabase.

NOTA:
Este paquete corrige el panel y los errores de esquema mostrados. Las políticas RLS de cada tabla deben permitir al administrador autenticado leer/escribir. No se incluye ninguna clave secreta de Supabase.


ACTUALIZACION - SLUG DE NOTICIAS
- Al escribir el título de una noticia, el campo Slug se genera automáticamente.
- El Slug se normaliza: minúsculas, sin tildes y palabras separadas por guiones.
- Al guardar, el panel vuelve a generarlo desde el título para evitar inconsistencias.
- El SQL agrega la columna news.slug si no existe y también crea un trigger en Supabase para generarlo automáticamente desde la base de datos.


VIDEO LOOP GOOGLE DRIVE
-----------------------
En En Vivo > Video loop puedes pegar directamente un enlace de Google Drive,
por ejemplo:
https://drive.google.com/file/d/1pU59WNaYLllFXcXtOJW_XzgnZ34P1OZw/view?usp=drive_link

El panel lo convierte automáticamente a:
https://drive.google.com/uc?export=download&id=1pU59WNaYLllFXcXtOJW_XzgnZ34P1OZw

La conversión se realiza antes de guardar en live_streams.loop_url.


CARGA DE IMAGENES DE EN VIVO
-----------------------------
1. Ejecuta supabase-reparacion.sql en Supabase.
2. El SQL crea el bucket público "live-images" y políticas para usuarios autenticados.
3. En Panel > En Vivo > Imagen de la transmisión, selecciona JPG/PNG/WEBP/GIF.
4. Al guardar, el archivo se sube a Storage/live-images/live/ y la URL pública se guarda en live_streams.image_url.
5. Máximo recomendado: 8 MB.

BANNERS: el panel ahora incluye 📢 Banners publicitarios. Ejecuta supabase-reparacion.sql para crear advertising_banners. Las imágenes se introducen por URL, con duración, orden, enlace y activo.


VERSION 6 - BANNERS VISIBLES EN EL PANEL
-----------------------------------------
Ahora aparece un botón destacado "📢 BANNERS PUBLICITARIOS"
debajo del menú del panel y una tarjeta en Dashboard.
También puede abrirse directamente con:
  /admin/panel.html#banners
  /admin/panel.html?seccion=banners

Ejecuta supabase-reparacion.sql para asegurar advertising_banners.
