FROM node:20-alpine

# Install ffmpeg and required tools
RUN apk add --no-cache ffmpeg tzdata

# Install n8n globally
RUN npm install -g n8n

USER node

WORKDIR /home/node

EXPOSE 5678

ENV N8N_USER_FOLDER=/home/node/.n8n

CMD ["n8n", "start"]
