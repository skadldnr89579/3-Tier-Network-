# Use Nginx to serve static files
FROM nginx:alpine

# Copy the static HTML/JS files from the 'templates' folder
# If the Dockerfile is in 'Personal' folder, use:
COPY templates/index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Run Nginx
CMD ["nginx", "-g", "daemon off;"]