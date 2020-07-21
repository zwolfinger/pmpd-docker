# Plex Movie Poster Display - Docker Version (pmpd-docker)
This is the docker image for [MattsShack/Plex-Movie-Poster-Display](https://github.com/MattsShack/Plex-Movie-Poster-Display) as presented at [https://www.mattsshack.com](https://www.mattsshack.com/plex-movie-poster-display/).

## Usage
You can run this container, from the command line using: `docker run -d -p 8080:8080 --name pmpd pmpd-docker:latest`

## Security recommendation
It is recommended you run this behind a reverse proxy (or secure the image to your needs), with added security measures such as preventing access to 'admin.php', whilst password protected the password is stored unhashed, in plaintext. There are likely other security concerns with this piece of software thus you should take appropriate precautions.

## Other
Configuration is stored locally at `/var/www/html/config.php`, updating, redeploying or doing anything other than stopping and starting this container will result in the need to setup again - this is a limitation of how this software has been developed.

