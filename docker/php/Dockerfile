FROM php:7.2-alpine

MAINTAINER Giovanni Battista Lenoci <gianiaz@gmail.com>

RUN apk --no-cache add \
        bash \
        git \
        netcat-openbsd \
        openssh-client \
        openssl-dev \
        nano \
        zlib-dev \
        sudo \
        wget \
        zsh \
 ## PHP-EXT
    && docker-php-ext-install -j5 \
        bcmath \
        mbstring \
        mysqli \
        opcache \
        pcntl \
        zip

RUN apk add --no-cache --virtual .xdebug-build-deps $PHPIZE_DEPS \
    && pecl install -o xdebug \
    && docker-php-ext-enable xdebug \
    && apk del .xdebug-build-deps \
    && pecl clear-cache \
    && docker-php-source delete

COPY conf/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

WORKDIR /var/www/spese

 ## Utente non-root (no sudo)
RUN adduser -D -u 1000 glenoci -G www-data -h /home/spese \
    && chown -R glenoci /var/www/spese \
 ## Composer and accounts
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
USER glenoci


 ## ZSH / OhMyZsh
COPY --chown=glenoci:www-data zsh/install-zsh.sh /home/spese/install-zsh.sh
RUN chmod +x /home/spese/install-zsh.sh \
    && /home/spese/install-zsh.sh
USER glenoci
COPY zsh/zsh-config.sh /home/spese/.zshrc
ENV TERM xterm-256color

## configs
COPY etc /usr/local/etc/php/



EXPOSE 9000
