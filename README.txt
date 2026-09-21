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
