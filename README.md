# Jóvenes Influencers del Señor

Sitio web estático para Vercel + GitHub + Supabase.

## Estructura
Cada sección tiene su propia carpeta con `index.html`, por ejemplo:
- `/iglesia-al-dia/`
- `/programas/`
- `/en-vivo/`
- `/64-datos/`
- `/diocesis/`
- `/editorial/`
- `/quienes-somos/`
- `/admin/`

Los 12 programas tienen subcarpetas dentro de `/programas/`.

## Vercel
Es un proyecto HTML/CSS/JavaScript estático. En Vercel selecciona **Other** si te pide framework; no requiere build command.

## Supabase
1. Abre SQL Editor.
2. Ejecuta `supabase.sql`.
3. Crea el usuario administrador en Authentication > Users.
4. Agrega su UUID a la tabla `admins`.

La Publishable Key está en `config.js`; nunca uses una service_role/secret key en el navegador.

## 64 datos históricos
La sección está configurada para mostrarse del 1 al 31 de octubre de 2026. El contenido se administra desde Supabase.
