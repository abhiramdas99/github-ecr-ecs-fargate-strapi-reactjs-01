# Base image
FROM node:16-alpine

# Set the working directory
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Strapi application
RUN npm run build

# Expose the port that Strapi will run on
EXPOSE 1337

# Start the Strapi server
CMD ["npm", "run", "start"]
