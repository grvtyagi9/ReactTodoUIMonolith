# Stage 1 Build the react app
FROM node:16.17.0-alpine as build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json file to the working directory
COPY package*.json .

# Install dependencies
RUN npm install
 # Copy the remaning application code
 COPY . .

 # Build the react app
 RUN npm run build

 # Stage 2: create a minimal production ready image
 FROM nginx-alpine

 # copy the  built app from the 'build' stage
 COPY --from=build /app/build /usr/share/nginx/html

 # Expose port
 EXPOSE 80
