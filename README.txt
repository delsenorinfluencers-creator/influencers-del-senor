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
