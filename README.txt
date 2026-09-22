PANEL REPARADO - JÓVENES INFLUENCERS DEL SEÑOR

Incluye:
- panel administrativo con barra lateral fija en PC;
- versión adaptable a celular;
- opción visible "🖼️ Banner publicitario";
- carga de banners mediante URL;
- duración configurable, por defecto 5 segundos;
- no envía "true" a columnas integer en la configuración;
- compatibilidad con SUPABASE_PUBLISHABLE_KEY y SUPABASE_KEY;
- favicon del panel conservado.

IMPORTANTE
Este paquete se construyó a partir del panel que fue proporcionado en la conversación. No contiene las demás páginas privadas de tu proyecto que no fueron adjuntadas.

TABLA PARA BANNERS
Si todavía no tienes la tabla banners en Supabase, ejecuta:

create table if not exists public.banners (
  id uuid primary key default gen_random_uuid(),
  image_url text not null,
  duration_seconds integer not null default 5,
  created_at timestamptz not null default now()
);

Luego habilita RLS según tus políticas de administración.

Para que el panel pueda insertar/eliminar, la sesión del administrador debe tener una política RLS que lo permita.

ERROR "invalid input syntax for type integer: true"
Ese error no debe solucionarse enviando true a una columna integer. La columna debe recibir un número (por ejemplo 1/0) o, si conceptualmente es verdadero/falso, debe ser boolean. La estructura exacta de la tabla de configuración no estaba incluida en el archivo proporcionado, por eso este panel no inventa nombres ni tipos de columnas.

INSTALACIÓN
1. Reemplaza admin/panel.html por el panel.html incluido.
2. Mantén tu config.js en la raíz.
3. El config.js incluido usa la clave pública que ya proporcionaste.
4. Si tu panel está en /admin/panel.html, conserva config.js en la raíz para que ../config.js funcione.
