-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create searches table
CREATE TABLE IF NOT EXISTS searches (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    query TEXT NOT NULL,
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create papers table
CREATE TABLE IF NOT EXISTS papers (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT NOT NULL,
    author TEXT NOT NULL,
    year INTEGER,
    abstract TEXT,
    doi TEXT,
    search_id UUID REFERENCES searches(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create index for search_id in papers
CREATE INDEX IF NOT EXISTS idx_papers_search_id ON papers(search_id);

-- Create pdf_uploads table
CREATE TABLE IF NOT EXISTS pdf_uploads (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    filename TEXT NOT NULL,
    title TEXT,
    authors TEXT,
    year INTEGER,
    doi TEXT,
    background TEXT,
    full_text TEXT,
    markdown_content TEXT,
    research_question TEXT,
    major_findings TEXT,
    suggestions TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create pdf_batches table
CREATE TABLE IF NOT EXISTS pdf_batches (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT NOT NULL,
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create batch_pdfs table (junction table for many-to-many relationship)
CREATE TABLE IF NOT EXISTS batch_pdfs (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    batch_id UUID REFERENCES pdf_batches(id) ON DELETE CASCADE,
    pdf_id UUID REFERENCES pdf_uploads(id) ON DELETE CASCADE,
    UNIQUE(batch_id, pdf_id)
);

-- Create indexes for batch_pdfs
CREATE INDEX IF NOT EXISTS idx_batch_pdfs_batch_id ON batch_pdfs(batch_id);
CREATE INDEX IF NOT EXISTS idx_batch_pdfs_pdf_id ON batch_pdfs(pdf_id);

-- Create firecrawl_api_keys table
CREATE TABLE IF NOT EXISTS firecrawl_api_keys (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    api_key TEXT NOT NULL,
    user_id UUID,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create zotero_credentials table
CREATE TABLE IF NOT EXISTS zotero_credentials (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    api_key TEXT NOT NULL,
    user_id TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create index for user_id in zotero_credentials
CREATE INDEX IF NOT EXISTS idx_zotero_credentials_user_id ON zotero_credentials(user_id);

-- Create storage bucket for PDFs if it doesn't exist
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM storage.buckets WHERE id = 'pdfs'
    ) THEN
        INSERT INTO storage.buckets (id, name)
        VALUES ('pdfs', 'pdfs');
    END IF;
END $$;

-- Enable RLS
ALTER TABLE searches ENABLE ROW LEVEL SECURITY;
ALTER TABLE papers ENABLE ROW LEVEL SECURITY;
ALTER TABLE pdf_uploads ENABLE ROW LEVEL SECURITY;
ALTER TABLE pdf_batches ENABLE ROW LEVEL SECURITY;
ALTER TABLE batch_pdfs ENABLE ROW LEVEL SECURITY;
ALTER TABLE firecrawl_api_keys ENABLE ROW LEVEL SECURITY;
ALTER TABLE zotero_credentials ENABLE ROW LEVEL SECURITY;

-- Create policies that allow all operations (for development)
DO $$
BEGIN
    -- searches
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies WHERE tablename = 'searches' AND policyname = 'Allow all operations on searches'
    ) THEN
        CREATE POLICY "Allow all operations on searches" ON searches FOR ALL USING (true);
    END IF;

    -- papers
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies WHERE tablename = 'papers' AND policyname = 'Allow all operations on papers'
    ) THEN
        CREATE POLICY "Allow all operations on papers" ON papers FOR ALL USING (true);
    END IF;

    -- pdf_uploads
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies WHERE tablename = 'pdf_uploads' AND policyname = 'Allow all operations on pdf_uploads'
    ) THEN
        CREATE POLICY "Allow all operations on pdf_uploads" ON pdf_uploads FOR ALL USING (true);
    END IF;

    -- pdf_batches
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies WHERE tablename = 'pdf_batches' AND policyname = 'Allow all operations on pdf_batches'
    ) THEN
        CREATE POLICY "Allow all operations on pdf_batches" ON pdf_batches FOR ALL USING (true);
    END IF;

    -- batch_pdfs
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies WHERE tablename = 'batch_pdfs' AND policyname = 'Allow all operations on batch_pdfs'
    ) THEN
        CREATE POLICY "Allow all operations on batch_pdfs" ON batch_pdfs FOR ALL USING (true);
    END IF;

    -- firecrawl_api_keys
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies WHERE tablename = 'firecrawl_api_keys' AND policyname = 'Allow all operations on firecrawl_api_keys'
    ) THEN
        CREATE POLICY "Allow all operations on firecrawl_api_keys" ON firecrawl_api_keys FOR ALL USING (true);
    END IF;

    -- zotero_credentials
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies WHERE tablename = 'zotero_credentials' AND policyname = 'Allow all operations on zotero_credentials'
    ) THEN
        CREATE POLICY "Allow all operations on zotero_credentials" ON zotero_credentials FOR ALL USING (true);
    END IF;
END $$;

-- Create storage policy
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM storage.policies WHERE name = 'Allow public access to PDFs'
    ) THEN
        CREATE POLICY "Allow public access to PDFs" ON storage.objects
            FOR ALL USING (bucket_id = 'pdfs');
    END IF;
END $$;
