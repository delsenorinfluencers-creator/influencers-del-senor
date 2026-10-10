PANEL ADMINISTRATIVO ACTUALIZADO
Jóvenes Influencers del Señor

CAMBIOS
1. Panel fijo en PC: la barra lateral queda fija y el contenido se desplaza sin mover el menú.
2. Celular: menú tipo hamburguesa, lateral desplegable y fondo de cierre. El contenido ocupa todo el ancho.
3. Botón “↻ Actualizar” y actualización automática del dashboard cada 30 segundos.
4. Nueva opción visible en el menú: “🖼️ Publicidad / Banner”.
5. Publicidad por URL, duración configurable (5 segundos por defecto), listado y eliminación.
6. Configuración reparada: ya NO utiliza la tabla de configuración antigua que provocaba “invalid input syntax for type integer: \"true\"”. Usa public.site_settings y guarda valores como texto; show_ads se guarda como 1/0.
7. Se mantiene el favicon/logo del panel.

PASOS
A) En Supabase > SQL Editor ejecuta COMPLETO:
   supabase_reparacion.sql

B) Sube/reemplaza:
   /admin/panel.html
   /config.js

C) Haz un redeploy en Vercel.

D) En el navegador usa Ctrl+F5 para limpiar la versión anterior.

PUBLICIDAD
En Panel > 🖼️ Publicidad / Banner:
- pega la URL directa de la imagen (JPG/PNG/WebP),
- deja 5 segundos o cambia la duración,
- pulsa “Agregar publicidad”.

NOTA
Una URL de página de Google Drive no es una URL directa de imagen. Para banners usa una URL que termine en .jpg, .jpeg, .png o .webp o una URL pública de un CDN/Storage.
