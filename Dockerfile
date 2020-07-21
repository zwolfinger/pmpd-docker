# Latest Ubuntu Server LTS 20.04 (Focal Fossa)
FROM ubuntu:20.04

MAINTAINER Wolfgeek <wolfgeek@me.com>

# (simple) Health Check
HEALTHCHECK CMD nc -vz localhost 8080 || exit 1

# Enviroment
ENV DEBIAN_FRONTEND=noninteractive

# Set timezone
ARG TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update APT
RUN apt update

## Install prerequisite
RUN apt install -y \\
nginx \\
php-fpm \\
php-xml \\
git \\
unclutter \\ 
netcat

# APT tidyup
RUN apt clean && \\
rm -rf /var/lib/apt/lists/*

# Configure NGINX
COPY files/nginx.default /etc/nginx/sites-available/default
COPY files/nginx.conf /etc/nginx

# Configure PHP-FPM
COPY files/php.ini /etc/php/7.4/fpm

# Copy startup script
COPY files/startup /usr/local/bin/startup
RUN chmod 775 /usr/local/bin/startup

# Setup Plex Movie Poster Display (clone repo)
RUN cd /opt && \\
git clone https://github.com/MattsShack/Plex-Movie-Poster-Display.git && \\
cp -R Plex-Movie-Poster-Display/* /var/www/html && \\ 
chmod -R 774 /var/www/html && \\
chown -R www-data:www-data /var/www/html && \\
rm -f /var/www/html/index.nginx-debian.html

# Expose port 8080 by default 
EXPOSE 8080

# Startup script
CMD ["/usr/local/bin/startup"]
