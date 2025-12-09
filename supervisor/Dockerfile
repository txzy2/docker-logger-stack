ARG PHP_VERSION=""

FROM php:8.2-fpm

# Set working directory 
WORKDIR /var/www/

RUN apt-get update && apt-get install -y \
    procps \
    git \
    mc \
    man \
    vim \
    acl \
    net-tools \
    iputils-ping \
    python3 \
    systemctl \
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
    zip \
    unzip \
    curl \
    wget \
    && docker-php-ext-install -j$(nproc) bcmath iconv mbstring mysqli pdo pdo_mysql pgsql pdo_pgsql zip exif \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-enable opcache

# Install Supervisor
RUN apt-get install -y supervisor

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir "/var/www/supervisor"

# RUN touch /var/log/supervisor/pg-payments-by-reqs.log
RUN touch /var/log/supervisor/supervisord.log

RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

CMD ["/usr/bin/supervisord", "-n", "-c",  "/etc/supervisor/supervisord.conf"]
