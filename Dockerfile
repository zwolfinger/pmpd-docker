FROM ubuntu:18.04
MAINTAINER Wolfgeek <wolfgeek@me.com>
ENV DEBIAN_FRONTEND=noninteractive
ARG TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y nginx php-fpm php-xml git unclutter && apt clean && rm -rf /var/lib/apt/lists/*
COPY nginx.default /etc/nginx/sites-available/default
COPY nginx.conf /etc/nginx
COPY php.ini /etc/php/7.2/fpm
COPY startup /usr/local/bin/startup
RUN chmod 775 /usr/local/bin/startup
RUN cd /opt && git clone https://github.com/MattsShack/Plex-Movie-Poster-Display.git && cp -R Plex-Movie-Poster-Display/* /var/www/html && chmod -R 774 /var/www/html && chown -R www-data:www-data /var/www/html && rm -f /var/www/html/index.nginx-debian.html
EXPOSE 80
CMD ["/usr/local/bin/startup"]
