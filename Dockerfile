# Use the official PHP-FPM image as the base image
FROM php:8.2-fpm

# Set the working directory in the container
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy Laravel files to the container
COPY . .

# Install application dependencies
RUN composer install

# Expose port 9000 to the host
EXPOSE 9000

# Start PHP-FPM server
CMD ["php-fpm"]
