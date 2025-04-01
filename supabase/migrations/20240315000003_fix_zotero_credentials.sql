-- Drop the existing table if it exists
DROP TABLE IF EXISTS public.zotero_credentials;

-- Create the zotero_credentials table with the correct schema
CREATE TABLE public.zotero_credentials (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    api_key TEXT NOT NULL,
    zotero_user_id TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    UNIQUE(user_id)
);

-- Enable RLS
ALTER TABLE public.zotero_credentials ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Users can view their own Zotero credentials"
    ON public.zotero_credentials FOR SELECT
    TO authenticated
    USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own Zotero credentials"
    ON public.zotero_credentials FOR INSERT
    TO authenticated
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own Zotero credentials"
    ON public.zotero_credentials FOR UPDATE
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own Zotero credentials"
    ON public.zotero_credentials FOR DELETE
    TO authenticated
    USING (auth.uid() = user_id);

-- Create an index for faster lookups
CREATE INDEX idx_zotero_credentials_user_id ON public.zotero_credentials(user_id); 