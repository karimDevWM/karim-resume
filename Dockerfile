# Stage 1: Build the Angular application
FROM node:18 as build

WORKDIR /app

# Copy the package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code and build it
COPY . .
RUN npm run build --prod

# Stage 2: Serve the application with Nginx
FROM nginx:alpine

# Copy the build output to the Nginx html directory
COPY --from=build /app/dist/karim-portfolio /usr/share/nginx/html

# Copy custom nginx configuration if needed
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]