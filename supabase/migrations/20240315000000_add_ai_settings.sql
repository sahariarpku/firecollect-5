-- Create ai_models table
CREATE TABLE IF NOT EXISTS public.ai_models (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT NOT NULL,
    provider TEXT NOT NULL,
    model_name TEXT NOT NULL,
    api_key TEXT NOT NULL,
    base_url TEXT,
    is_default BOOLEAN DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable RLS
ALTER TABLE public.ai_models ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Anyone can read ai_models"
    ON public.ai_models FOR SELECT
    TO authenticated
    USING (true);

CREATE POLICY "Only admins can insert ai_models"
    ON public.ai_models FOR INSERT
    TO authenticated
    WITH CHECK (auth.jwt() ->> 'email' = any(string_to_array(current_setting('app.admin_emails'), ',')));

CREATE POLICY "Only admins can update ai_models"
    ON public.ai_models FOR UPDATE
    TO authenticated
    USING (auth.jwt() ->> 'email' = any(string_to_array(current_setting('app.admin_emails'), ',')))
    WITH CHECK (auth.jwt() ->> 'email' = any(string_to_array(current_setting('app.admin_emails'), ',')));

CREATE POLICY "Only admins can delete ai_models"
    ON public.ai_models FOR DELETE
    TO authenticated
    USING (auth.jwt() ->> 'email' = any(string_to_array(current_setting('app.admin_emails'), ',')));

-- Create user_settings table
CREATE TABLE IF NOT EXISTS public.user_settings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    ai_model UUID REFERENCES public.ai_models(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    UNIQUE(user_id)
);

-- Enable RLS
ALTER TABLE public.user_settings ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Users can view their own settings"
    ON public.user_settings FOR SELECT
    TO authenticated
    USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own settings"
    ON public.user_settings FOR INSERT
    TO authenticated
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own settings"
    ON public.user_settings FOR UPDATE
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own settings"
    ON public.user_settings FOR DELETE
    TO authenticated
    USING (auth.uid() = user_id);

-- Insert default AI model
insert into public.ai_models (name, provider, model_name, api_key, is_default)
values ('Default OpenAI', 'openai', 'gpt-4-turbo-preview', current_setting('app.openai_api_key'), true); 