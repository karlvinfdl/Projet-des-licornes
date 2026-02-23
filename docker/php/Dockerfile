# PHP-FPM Dockerfile for Symfony
FROM php:8.3-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libpq-dev \
    postgresql-client \
    nodejs \
    npm

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_pgsql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy application files
COPY . .

# Install dependencies (skip scripts initially to avoid errors, then run cache:clear manually)
RUN composer install --no-dev --optimize-autoloader --no-scripts \
    && composer dump-autoload --optimize \
    && chmod +x bin/console \
    && php bin/console cache:clear --env=prod --no-debug \
    || true

# Set permissions
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www/var

# Expose port 9000
EXPOSE 9000

CMD ["php-fpm"]

