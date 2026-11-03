-- REVISTA DIGITAL: tabla pública con lector Issuu y PDF opcional
create table if not exists public.magazines (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  edition text,
  description text,
  cover_url text,
  reader_url text,
  pdf_url text,
  published boolean not null default false,
  published_at date default current_date,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.magazines add column if not exists edition text;
alter table public.magazines add column if not exists description text;
alter table public.magazines add column if not exists cover_url text;
alter table public.magazines add column if not exists reader_url text;
alter table public.magazines add column if not exists pdf_url text;
alter table public.magazines add column if not exists published boolean not null default false;
alter table public.magazines add column if not exists published_at date default current_date;
alter table public.magazines add column if not exists created_at timestamptz default now();
alter table public.magazines add column if not exists updated_at timestamptz default now();

alter table public.magazines enable row level security;
drop policy if exists magazines_public_read on public.magazines;
create policy magazines_public_read on public.magazines for select using (published = true or public.is_admin());
drop policy if exists magazines_admin_all on public.magazines;
create policy magazines_admin_all on public.magazines for all to authenticated using (public.is_admin()) with check (public.is_admin());

-- Nueva edición HECHOS. ON CONFLICT evita duplicarla si se ejecuta de nuevo.
create unique index if not exists magazines_hechos_digital1_unique
  on public.magazines (edition) where edition = 'Revista Digital 1';

insert into public.magazines (title, edition, description, cover_url, reader_url, published, published_at)
values (
  'HECHOS',
  'Revista Digital 1',
  'Nueva edición de la revista HECHOS. Léela gratuitamente en nuestro sitio.',
  'https://cdn.phototourl.com/member/2026-11-03-785cd0ca-3f07-4b90-ae5a-19fdb08ba6eb.jpg',
  'https://e.issuu.com/embed.html?backgroundColorFullscreen=&d=revista_digital_1_&u=influencersdelsenor',
  true,
  current_date
)
on conflict (edition) where edition = 'Revista Digital 1'
do update set title=excluded.title, description=excluded.description,
  cover_url=excluded.cover_url, reader_url=excluded.reader_url,
  published=true, published_at=excluded.published_at, updated_at=now();

notify pgrst, 'reload schema';
