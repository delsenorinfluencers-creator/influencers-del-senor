-- MIGRACIÓN SEGURA: URLs amigables para noticias
-- Ejecutar en Supabase SQL Editor.
-- No elimina registros ni cambia el UUID de las noticias.

alter table public.news add column if not exists slug text;

create or replace function public.jis_slugify(value text)
returns text
language plpgsql
immutable
as $$
declare s text;
begin
  s := lower(coalesce(value,''));
  s := translate(s,
    'áéíóúàèìòùäëïöüâêîôûãõñçÁÉÍÓÚÀÈÌÒÙÄËÏÖÜÂÊÎÔÛÃÕÑÇ',
    'aeiouaeiouaeiouaeiouancAEIOUAEIOUAEIOUAEIOUANC');
  s := regexp_replace(s, '[^a-z0-9]+', '-', 'g');
  s := trim(both '-' from s);
  return left(s,140);
end;
$$;

-- Rellena slugs que todavía estén vacíos.
update public.news
set slug = public.jis_slugify(title)
where coalesce(trim(slug),'') = ''
  and title is not null;

-- Si existen títulos repetidos, agrega -2, -3, etc. para evitar colisiones.
do $$
declare r record; base text; candidate text; n integer;
begin
  for r in select id,title,slug from public.news where coalesce(trim(slug),'') <> '' order by created_at nulls last, id loop
    base := public.jis_slugify(r.title);
    candidate := base;
    n := 1;
    while exists(select 1 from public.news x where x.slug=candidate and x.id<>r.id) loop
      n := n + 1;
      candidate := left(base, 135) || '-' || n::text;
    end loop;
    if r.slug is distinct from candidate then
      update public.news set slug=candidate where id=r.id;
    end if;
  end loop;
end $$;

create unique index if not exists news_slug_unique_idx
on public.news(slug)
where slug is not null and slug <> '';

create or replace function public.generate_news_slug()
returns trigger
language plpgsql
as $$
declare base text; candidate text; n integer;
begin
  if new.title is not null then
    base := public.jis_slugify(new.title);
    candidate := base;
    n := 1;
    while exists(select 1 from public.news x where x.slug=candidate and x.id<>coalesce(new.id,'00000000-0000-0000-0000-000000000000'::uuid)) loop
      n := n + 1;
      candidate := left(base, 135) || '-' || n::text;
    end loop;
    new.slug := candidate;
  end if;
  return new;
end;
$$;

drop trigger if exists news_generate_slug on public.news;
create trigger news_generate_slug
before insert or update of title on public.news
for each row execute function public.generate_news_slug();

-- Comprobación
select id,title,slug from public.news order by created_at desc nulls last limit 20;
