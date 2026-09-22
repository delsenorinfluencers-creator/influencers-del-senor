# Jóvenes Influencers del Señor - sitio web

Proyecto estático para Vercel + Supabase.

## 1. Subir a GitHub / Vercel

Sube **todos los archivos y carpetas** conservando esta estructura. En Vercel selecciona el repositorio y despliega como proyecto estático.

## 2. Supabase

1. Abre Supabase > SQL Editor.
2. Ejecuta `supabase.sql` completo.
3. En Authentication > Users crea el usuario administrador.
4. Copia su UUID.
5. Al final de `supabase.sql` hay una sentencia comentada de BOOTSTRAP. Sustituye `YOUR_ADMIN_UUID` por el UUID y ejecuta esa sentencia.
6. Cierra sesión y vuelve a entrar en `/admin/`.

Esto evita los errores anteriores de `email`, `role`, `active`, RLS y columnas de `live_streams`.

## 3. Panel

- `/admin/` inicia sesión.
- `/admin/panel.html` es el panel.
- Dashboard
- Iglesia al Día
- Los 11 programas y episodios
- En Vivo: M3U8, Facebook, YouTube y video loop
- 64 Datos
- Diócesis
- Integrantes
- Editorial
- Usuarios / administradores
- Configuración
- Carga de imágenes a Supabase Storage (`media`)

## 4. Señal en vivo

En el panel > En Vivo:

- `type = m3u8` para una URL `.m3u8`.
- `type = youtube` para YouTube.
- `type = facebook` para una URL pública/embebible de Facebook.
- `loop_url` permite colocar un video MP4 de respaldo en loop.
- `active = true` y `show_live = true` muestran la señal en `/en-vivo/` y en Inicio.

La detección automática de que una página de Facebook está transmitiendo requiere la API de Meta y permisos de la página; una página web no puede consultar ese estado directamente solo con la URL pública.

## 5. Logo y favicon

Todas las páginas incluyen el mismo logo del proyecto en el menú, pie de página y favicon. El valor se centraliza en `config.js`.

## 6. Seguridad

La clave `sb_publishable_...` es una clave pública diseñada para el navegador. Nunca pongas una `service_role` en `config.js` ni en ningún archivo público.
