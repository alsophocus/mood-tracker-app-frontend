# Build stage
FROM ghcr.io/cirruslabs/flutter:stable AS build

# Set working directory
WORKDIR /app

# Copy pubspec files
COPY pubspec.* ./

# Get dependencies
RUN flutter pub get

# Copy the rest of the application
COPY . .

# Build Flutter web app
RUN flutter build web --release --web-renderer canvaskit

# Production stage
FROM nginx:alpine

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy built Flutter web app from build stage
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port 8080 (Railway requirement)
EXPOSE 8080

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
