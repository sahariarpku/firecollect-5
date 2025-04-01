-- Drop the existing table if it exists
DROP TABLE IF EXISTS public.zotero_credentials;

-- Create the table with the correct structure
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
    USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own Zotero credentials"
    ON public.zotero_credentials FOR INSERT
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own Zotero credentials"
    ON public.zotero_credentials FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own Zotero credentials"
    ON public.zotero_credentials FOR DELETE
    USING (auth.uid() = user_id); 