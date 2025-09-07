ARG PHP=""
FROM php:8.2-fpm

MAINTAINER Kamaev Anton

# Set working directory 
WORKDIR /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
    librdkafka-dev \
    exim4 \
    librabbitmq-dev \
    procps \
    git \
    mc \
    net-tools \
    iputils-ping \
    python3 python3-dev python3-pip \
    man \
    vim \
    acl \
    libpq-dev \
    libonig-dev \
    libicu-dev \
    libwebp-dev \
    libjpeg62-turbo-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxpm-dev \
    libvpx-dev \
    imagemagick \
    libpng-dev \
    libxml2-dev \
    libzip-dev \
    lua-zlib-dev \
    libmcrypt-dev \
    zip \
    unzip \
    curl \
    wget \
    && pecl install -n mcrypt \
    && docker-php-ext-enable mcrypt \
    && docker-php-ext-install -j$(nproc) bcmath iconv mbstring mysqli pdo pdo_mysql pgsql pdo_pgsql zip exif \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && pecl install rdkafka \
    && docker-php-ext-enable rdkafka \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# set up mailing
RUN sed -i 's@local@internet@' /etc/exim4/update-exim4.conf.conf \
  && update-exim4.conf

# Install Node.js v22 and Yarn
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get update \
    && apt-get install -y nodejs \
    && npm install -g yarn \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add user for laravel application
RUN groupadd -g 1000 www \
    && useradd -u 1000 -ms /bin/bash -g www www

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
