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
sudo apt-get install software-properties-common -y

sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.2/ubuntu xenial main'
apt-get update -y

# Setting MySQL root user password root/root
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get install -y mariadb-server mariadb-client

# Install the Rest
sudo apt-get install -y php7.1 libapache2-mod-php7.1 php7.1-curl php7.1-gd php7.1-mcrypt php7.1-xdebug php7.1-mysql php7.1-dom php7.1-cli php7.1-json php7.1-common php7.1-mbstring php7.1-opcache php7.1-readline php7.1-soap
sudo a2enmod rewrite
sudo a2enmod headers
sudo a2enmod ssl
sudo service apache2 restart