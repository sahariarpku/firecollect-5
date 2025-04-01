# FireCollect

FireCollect is a powerful research tool that helps academics and researchers manage their papers, PDFs, and Zotero libraries. It features AI-powered search capabilities, PDF analysis, and seamless Zotero integration.

![FireCollect Interface](./public/firecollect-interface.png)

## Features

- 🔍 **Academic Paper Search**: Search and analyze academic papers with AI assistance
- 📄 **PDF Analysis**: Upload and analyze PDFs with automatic metadata extraction
- 📚 **Zotero Integration**: Connect and manage your Zotero library
- 🤖 **AI-Powered**: Intelligent paper analysis and chat capabilities
- 📱 **Modern UI**: Clean, responsive interface with dark mode support
- 🔐 **Secure**: Built-in authentication and API key management

## Prerequisites

Before you begin, ensure you have the following installed:
- Node.js (v18 or higher)
- npm or yarn
- Git
- Supabase account (for database and authentication)
- Firecrawl API key (for AI features)

## Setup Instructions

### 1. Clone the repository
```bash
git clone https://github.com/sahariarpku/firecollect-5.git
cd firecollect-5
```

### 2. Install dependencies
```bash
npm install
# or
yarn install
```

### 3. Supabase Setup

#### a. Create a Supabase Project

1. Go to [Supabase Dashboard](https://supabase.com/dashboard)
2. Click "New Project"
3. Fill in your project details:
   - Name your project
   - Set a secure database password
   - Choose a region closest to your users
4. Wait for the project to be created

#### b. Get Your Project Credentials

1. Go to your project's dashboard
2. Navigate to Project Settings > API
3. Copy these values:
   - Project URL (under "Project URL")
   - Project API Keys (both `anon` and `service_role` keys)
   - Project Reference ID (under "Project Reference ID")
4. Go to Project Settings > Database
5. Copy your database password (or reset it if needed)

#### c. Configure Environment Variables

1. Copy the example environment file:
   ```bash
   cp .env.example .env.local
   ```

2. Update `.env.local` with your Supabase credentials:
   ```
   NEXT_PUBLIC_SUPABASE_URL=your_project_url
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key
   SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
   SUPABASE_DB_PASSWORD=your_database_password
   SUPABASE_PROJECT_ID=your_project_id
   ```

#### d. Initialize Supabase

1. Install Supabase CLI:
   ```bash
   npm install supabase --save-dev
   ```

2. Initialize Supabase (this will create necessary configuration files):
   ```bash
   npx supabase init
   ```

3. Link your project:
   ```bash
   npx supabase link --project-ref your_project_id
   ```

4. Push the database schema:
   ```bash
   npx supabase db push
   ```

### Troubleshooting Supabase Setup

If you encounter any issues:

1. **Wrong Database Connection**
   - Double-check your database password in `.env.local`
   - Ensure your project is active in the Supabase dashboard
   - Try resetting your database password in Supabase dashboard

2. **Project Linking Issues**
   - Verify your project ID is correct
   - Make sure you're logged in to Supabase CLI (`npx supabase login`)
   - Check if your project is active in the dashboard

3. **Permission Issues**
   - Verify your service role key has the correct permissions
   - Check if your project's database is not paused

### 4. Start the development server
```bash
npm run dev
# or
yarn dev
```

The application will be available at `http://localhost:3000`

## Project Structure

```
firecollect-5/
├── src/
│   ├── components/        # React components
│   ├── services/         # API and service integrations
│   ├── lib/             # Utility functions and configurations
│   ├── types/           # TypeScript type definitions
│   └── app/             # Next.js app router files
├── public/              # Static assets
├── supabase/           # Supabase configurations and migrations
└── styles/             # Global styles and CSS modules
```

## Key Components

- **ResearchManager**: Handles academic paper search and analysis
- **PDFUploadView**: Manages PDF uploads and analysis
- **ZoteroConnect**: Handles Zotero library integration
- **UserProfile**: User settings and API key management

## Authentication

The app uses Supabase Authentication. Users can:
- Sign up with email/password
- Sign in with existing account
- Reset password
- Manage API keys and settings

## API Keys

Two types of API keys are required:
1. **Firecrawl API Key**: For AI-powered paper analysis
   - Get it from [firecrawl.dev](https://firecrawl.dev)
   - Add it in the user settings

2. **Zotero API Key**: For Zotero integration
   - Generate from [Zotero settings](https://www.zotero.org/settings/keys)
   - Add it when connecting Zotero

## Troubleshooting

### Common Database Issues

1. **Wrong Database Connection**
   - Ensure your `.env.local` has the correct Supabase credentials
   - Make sure `supabase/config.toml` has the correct project ID
   - Try relinking your project:
     ```bash
     npx supabase link --project-ref your-project-id --debug
     ```

2. **Migration Errors**
   - Clear local Supabase configuration:
     ```bash
     rm -rf .supabase
     npx supabase init
     ```
   - Relink and push:
     ```bash
     npx supabase link --project-ref your-project-id
     npx supabase db push
     ```

3. **Permission Issues**
   - Verify your service role key has the correct permissions
   - Check RLS policies in Supabase dashboard

## Development

### Running Tests
```bash
npm run test
# or
yarn test
```

### Building for Production
```bash
npm run build
# or
yarn build
```

### Linting
```bash
npm run lint
# or
yarn lint
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support, please open an issue in the GitHub repository or contact the maintainers.
