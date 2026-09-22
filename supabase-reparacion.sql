-- REPARACIÓN SEGURA DEL PANEL ADMINISTRATIVO
-- No elimina tablas ni cambia tipos existentes.

alter table public.editorials add column if not exists created_at timestamptz;
alter table public.editorials add column if not exists updated_at timestamptz;
update public.editorials set created_at=coalesce(created_at,now()) where created_at is null;
update public.editorials set updated_at=coalesce(updated_at,now()) where updated_at is null;

alter table public.live_streams add column if not exists image_url text;
alter table public.live_streams add column if not exists loop_url text;
alter table public.live_streams add column if not exists show_live boolean default false;
alter table public.live_streams add column if not exists type text;
alter table public.live_streams add column if not exists url text;
alter table public.live_streams add column if not exists title text;

alter table public.programs add column if not exists sort_order integer;

alter table public.news add column if not exists created_at timestamptz;
alter table public.news add column if not exists updated_at timestamptz;
alter table public.programs add column if not exists created_at timestamptz;
alter table public.programs add column if not exists updated_at timestamptz;
alter table public.episodes add column if not exists created_at timestamptz;
alter table public.episodes add column if not exists updated_at timestamptz;
alter table public.historical_64 add column if not exists created_at timestamptz;
alter table public.historical_64 add column if not exists updated_at timestamptz;

-- NO convertir published/active a boolean.
-- El panel nuevo no envía true a columnas INTEGER.

select table_name,column_name,data_type,udt_name
from information_schema.columns
where table_schema='public'
and table_name in ('admins','news','programs','episodes','live_streams','historical_64','diocese','parishes','team_members','editorials','site_settings')
order by table_name,ordinal_position;
