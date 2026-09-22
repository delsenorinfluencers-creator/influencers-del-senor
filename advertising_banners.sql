CREATE TABLE IF NOT EXISTS public.advertising_banners (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    title text,
    image_url text NOT NULL,
    link_url text,
    duration_seconds integer NOT NULL DEFAULT 5,
    sort_order integer NOT NULL DEFAULT 0,
    active boolean NOT NULL DEFAULT true,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_advertising_banners_order
ON public.advertising_banners(sort_order);

CREATE INDEX IF NOT EXISTS idx_advertising_banners_active
ON public.advertising_banners(active);

NOTIFY pgrst, 'reload schema';
