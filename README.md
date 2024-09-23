# Build a Cloudflare Pages with Next.js Static Export, within Docker

Next.js enables starting as a static site or Single-Page Application (SPA), then later optionally upgrading to use features that require a server.

When running `npm run build`, Next.js generates an HTML file per route. By breaking a strict SPA into individual HTML files, Next.js can avoid loading unnecessary JavaScript code on the client-side, reducing the bundle size and enabling faster page loads.

Learn more: https://nextjs.org/docs/app/building-your-application/deploying/static-exports

## Create Project

### Create a next.js microsite
```bash
npx create-next-app --example with-static-export nextjs-microsite
```

### Modify package.json to set the dependencies to
```json
  "dependencies": {
    "@cloudflare/next-on-pages": "^1.13.3",
    "@cloudflare/workers-types": "^4.20240919.0",
    "@types/node": "^20",
    "@types/react": "^18.0.23",
    "@types/react-dom": "^18.0.7",
    "next": "latest",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "serve": "^14.2.0",
    "typescript": "^5",
    "vercel": "^37.5.4",
    "wrangler": "^3.78.8"
  }
```

### Update package-lock.json
```bash
npm update
```

### Create Dockerfile at the parent directory of "nextjs-microsite" folder
[Dockerfile](Dockerfile)

## Build and Run Docker Image

### Build the docker image defined in the current folder with "my-microsite" as the tag
```bash
docker build -t my-microsite .
```

### Inspect a docker image (optional)
```bash
docker image inspect my-microsite
```

### Run the image
```bash
docker run -it my-microsite /bin/sh
```

### Inside the image
#### Build the project
```bash
npm run build
```
(The generated documents can be found at "out" directory.)

#### Upload the project to Cloudflare
```bash
CLOUDFLARE_API_TOKEN="<api-token>" CLOUDFLARE_ACCOUNT_ID="<account-id>" npx wrangler pages deploy out --project-name=curl-project1
```
