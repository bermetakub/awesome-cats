FROM node:14-slim

WORKDIR /app

# Copy application files
COPY package*.json ./

# Install dependencies
RUN npm install
COPY . . 
ENV NODE_ENV=production

# Run the application
CMD ["node", "server.js"]

