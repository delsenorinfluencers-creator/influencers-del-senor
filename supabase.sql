-- Base inicial para Jóvenes Influencers del Señor
-- Ejecutar en Supabase > SQL Editor

create extension if not exists "pgcrypto";

create table if not exists news (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  summary text,
  content text,
  image_url text,
  video_url text,
  video_type text check (video_type in ('youtube','facebook')),
  category text default 'Iglesia al Día',
  published boolean default false,
  published_at timestamptz,
  created_at timestamptz default now()
);

create table if not exists historical_data (
  id uuid primary key default gen_random_uuid(),
  number integer unique not null check (number between 1 and 64),
  title text not null,
  description text,
  image_url text,
  video_url text,
  video_type text check (video_type in ('youtube','facebook')),
  published boolean default false,
  published_at timestamptz,
  active_from date default '2026-10-01',
  active_until date default '2026-11-01',
  created_at timestamptz default now()
);

create table if not exists parishes (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  municipality text,
  address text,
  priest text,
  phone text,
  mass_schedule text,
  image_url text
);

create table if not exists team_members (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  role text,
  bio text,
  image_url text
);

create table if not exists advocations (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  history text,
  feast_date text,
  parish text,
  image_url text
);

create table if not exists editorials (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  excerpt text,
  content text not null,
  author text,
  image_url text,
  published boolean default false,
  published_at timestamptz
);
