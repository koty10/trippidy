# Start by building the application
FROM ghcr.io/cirruslabs/flutter:stable AS build

# Set up a working directory
WORKDIR /app

# Copy Flutter app files to the container
COPY . .

# Get Flutter dependencies
RUN flutter pub get

RUN dart pub upgrade

RUN dart run build_runner build --delete-conflicting-outputs

# Build the Flutter web app
RUN flutter build web

# Now, start from the Nginx base image to serve the app
FROM nginx:alpine

# Remove the default Nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy the built Flutter app to the Nginx serve directory
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port 80 for the web server (this should match the port in your docker-compose and Nginx configuration)
EXPOSE 80

# Start Nginx and keep it running in the foreground
CMD ["nginx", "-g", "daemon off;"]
