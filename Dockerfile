FROM php:8.2-apache

# Ativar mod_rewrite
RUN a2enmod rewrite

# Instalar dependências do PHP e extensões comuns
RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip git curl nano \
    libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-install pdo pdo_mysql zip gd

# Definir DocumentRoot para Laravel
RUN sed -i 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/000-default.conf

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instalar Node.js e npm
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# Definir diretório de trabalho
WORKDIR /var/www/html

# Copiar código do projeto
COPY ./src /var/www/html

# Ajustar permissões para o Apache
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expor porta 80
EXPOSE 80
