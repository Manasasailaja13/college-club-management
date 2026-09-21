create extension if not exists pgcrypto;

create table if not exists public.students (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  roll_number text not null unique,
  email text not null unique,
  department text not null,
  year text not null,
  phone text,
  password_hash text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.clubs (
  id text primary key,
  name text not null,
  category text not null,
  icon text,
  members integer not null default 0,
  description text not null,
  image text,
  objectives jsonb not null default '[]'::jsonb,
  coordinator text,
  student_lead text,
  created_at timestamptz not null default now()
);

create table if not exists public.events (
  id text primary key,
  name text not null,
  club text not null,
  category text not null,
  event_date text not null,
  event_time text not null,
  venue text not null,
  image text,
  description text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.memberships (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references public.students(id) on delete cascade,
  club_id text not null references public.clubs(id) on delete cascade,
  department text,
  year text,
  phone text,
  reason text,
  skills text,
  status text not null default 'pending' check (status in ('pending', 'approved', 'rejected')),
  created_at timestamptz not null default now(),
  unique(student_id, club_id)
);

create table if not exists public.event_registrations (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references public.students(id) on delete cascade,
  event_id text not null references public.events(id) on delete cascade,
  created_at timestamptz not null default now(),
  unique(student_id, event_id)
);

create table if not exists public.contact_messages (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  email text not null,
  subject text not null,
  message text not null,
  created_at timestamptz not null default now()
);

alter table public.students enable row level security;
alter table public.clubs enable row level security;
alter table public.events enable row level security;
alter table public.memberships enable row level security;
alter table public.event_registrations enable row level security;
alter table public.contact_messages enable row level security;

create policy "public can read clubs" on public.clubs for select using (true);
create policy "public can read events" on public.events for select using (true);
