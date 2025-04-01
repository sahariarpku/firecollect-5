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

1. **Clone the repository**
```bash
git clone https://github.com/sahariarpku/firecollect-5.git
cd firecollect-5
```

2. **Install dependencies**
```bash
npm install
# or
yarn install
```

3. **Environment Setup**
Create a `.env.local` file in the root directory with the following variables:
```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
NEXT_PUBLIC_FIRECRAWL_API_URL=https://api.firecrawl.dev
```

4. **Database Setup**
Run the Supabase migrations to set up your database:
```bash
npx supabase db push
```

5. **Start the development server**
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
