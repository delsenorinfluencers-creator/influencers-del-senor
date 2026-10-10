-- Corrección del error: invalid input syntax for type uuid: "1"
-- La columna id identifica internamente cada registro y es UUID.
-- El número visible del dato histórico debe guardarse en la columna number.
alter table public.historical_64 add column if not exists number integer;

-- Si ya existen registros, asigna número visible cuando esté vacío.
with numbered as (
  select id, row_number() over (order by created_at nulls first, id) as n
  from public.historical_64 where number is null
)
update public.historical_64 h set number = numbered.n
from numbered where h.id = numbered.id;

create unique index if not exists historical_64_number_unique
  on public.historical_64(number) where number is not null;

notify pgrst, 'reload schema';
