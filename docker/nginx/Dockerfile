# Nginx Dockerfile for Symfony
FROM nginx:1.25-alpine

# Copy custom nginx configuration
COPY docker/nginx/conf.d /etc/nginx/conf.d

# Set working directory
WORKDIR /var/www

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
