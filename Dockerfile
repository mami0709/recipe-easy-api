FROM php:8.1-fpm

# プロジェクトのファイルをコピー
COPY . /var/www/html

# 必要なツールとPHP拡張機能のインストール
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    default-mysql-client \
 && docker-php-ext-install zip pdo pdo_mysql

# Composerのインストール
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

# 必要なパッケージのインストール
RUN composer install

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]