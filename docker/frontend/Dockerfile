FROM node:20-slim

WORKDIR /app

# Install dependencies inside the container to get correct platform binaries
# Use a temporary package.json without @openai/chat-components (not on public npm)
COPY frontend/package.json ./package-original.json
RUN node -e " \
  const pkg = require('./package-original.json'); \
  delete pkg.dependencies['@openai/chat-components']; \
  require('fs').writeFileSync('./package.json', JSON.stringify(pkg, null, 2));"

COPY frontend/package-lock.json ./
RUN npm install

# Restore original package.json
RUN cp package-original.json package.json

COPY frontend/ ./

# Build args become env vars at build time for NEXT_PUBLIC_ prefixed vars
ARG NEXT_PUBLIC_API_BASE_URL=http://localhost:7860
ARG NEXT_PUBLIC_BETTER_AUTH_URL=http://localhost:3000
ARG NEXT_PUBLIC_APP_NAME="Todo Dashboard"

ENV NEXT_PUBLIC_API_BASE_URL=$NEXT_PUBLIC_API_BASE_URL
ENV NEXT_PUBLIC_BETTER_AUTH_URL=$NEXT_PUBLIC_BETTER_AUTH_URL
ENV NEXT_PUBLIC_APP_NAME=$NEXT_PUBLIC_APP_NAME

RUN npm run build

ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000

CMD ["npx", "next", "start", "-p", "3000"]
