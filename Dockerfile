FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
		libfreetype-dev \
		libjpeg62-turbo-dev \
		libpng-dev \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install mysqli pdo pdo_mysql


# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY . .

# Runtime stage
FROM nginx:alpine

# Copy built application from previous stage
COPY . /var/www/html/rank_api/

RUN pwd
# Copy Nginx configuration
COPY ./docker/nginx/rank.conf /etc/nginx/conf.d/rank.conf

# Expose port
EXPOSE 80

# Set entrypoint
CMD ["nginx", "-g", "daemon off;"]
