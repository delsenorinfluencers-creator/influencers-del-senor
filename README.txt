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
