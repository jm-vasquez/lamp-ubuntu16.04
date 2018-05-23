#!/usr/bin/env bash

apt-get update -y
apt-get install -y apache2 libapache2-mod-fastcgi apache2-mpm-worker
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

# Loading needed modules to make apache work
a2enmod actions fastcgi rewrite
service apache2 reload

# Add repo for latest PHP
sudo add-apt-repository -y ppa:ondrej/php
apt-get update -y
sudo apt-get install software-properties-common -y


# Install the Rest
sudo apt-get install -y php5.6 libapache2-mod-php5.6 php5.6-curl php5.6-gd php5.6-mcrypt php5.6-xdebug php5.6-mysql php5.6-dom php5.6-cli php5.6-json php5.6-common php5.6-mbstring php5.6-opcache php5.6-readline
sudo a2enmod rewrite
sudo a2enmod headers
sudo service apache2 restart