# Jóvenes Influencers del Señor — Web completa

Subpáginas:
- `/` Inicio
- `/iglesia-al-dia/` Noticias y videos
- `/programas/` Todos los programas
- `/programas/.../` Una página para cada programa
- `/en-vivo/` Señal en vivo HLS
- `/64-datos/` Especial de octubre 2026
- `/diocesis/` Historia, parroquias y advocaciones
- `/editorial/` Editorial
- `/quienes-somos/` Equipo
- `/admin/` Panel administrativo

## Vercel
Framework Preset: `Other`
Root Directory: `./`
Build Command: vacío
Output Directory: vacío

## Supabase
1. Ejecuta `supabase.sql` en SQL Editor.
2. En Authentication > Users crea el usuario administrador.
3. Copia su UUID y ejecuta:
`insert into public.admins(id) values ('UUID-DEL-USUARIO');`
4. Para la señal, edita `config.js` y coloca la URL `.m3u8` real en `LIVE_STREAM_URL`.

No coloques una `service_role` key en el navegador.

## GitHub
Sube todos los archivos y carpetas del ZIP conservando la estructura.


## Versión sin carpetas
Todos los HTML están en la raíz del repositorio. Los nombres de los programas comienzan con `programa-`.
