#! /bin/bash

# Change this to i386-linux-gnu if needed
arch = 'x86_64-linux-gnu'

set -e

sudo apt-get update
sudo apt-get install libldap2-dev \
  libldap-2.4-2 \
  libtool-bin \
  libzip-dev \
  lbzip2 \
  libxml2-dev \
  bzip2 \
  re2c \
  libbz2-dev \
  apache2-dev \
  libjpeg-dev \
  libxpm-dev \
  libxpm-dev \
  libgmp-dev \
  libgmp3-dev \
  libmcrypt-dev \
  libmysqlclient-dev \
  mysql-server \
  mysql-common \
  libpspell-dev \
  librecode-dev \
  libcurl4-openssl-dev \
  libxft-dev \
  libldb-dev \
  libldap2-dev
  libreadline-dev \
  libmcrypt-dev \
  memcached \ 
  libmemcached-dev

sudo ln -sf /usr/lib/$arch/libldap.so /usr/lib/libldap.so
sudo ln -sf /usr/lib/$arch/liblber.so /usr/lib/liblber.so
sudo ln -sf /usr/include/$arch/gmp.h /usr/include/gmp.h

git clone https://github.com/php/php-src
cd php-src
git checkout php-7.2.5

./buildconf --force
./configure --prefix=/usr/local/php7 --with-config-file-path=/etc/php7/apache2 --with-config-file-scan-dir=/etc/php7/apache2/conf.d --enable-mbstring --enable-zip --enable-bcmath --enable-pcntl --enable-ftp --enable-exif --enable-calendar --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-wddx --enable-intl --with-curl --with-iconv --with-gmp=/usr/include/$arch --with-pspell --with-gd --with-jpeg-dir=/usr --with-png-dir=/usr --with-zlib-dir=/usr --with-xpm-dir=/usr --with-freetype-dir=/usr --enable-gd-jis-conv --with-openssl --with-pdo-mysql=/usr --with-gettext=/usr --with-zlib=/usr --with-bz2 --with-recode=/usr --with-apxs2=/usr/bin/apxs --with-mysqli=/usr/bin/mysql_config --with-ldap --enable-sockets --with-system-ciphers --with-readline

make clean

cpunum=$((`cat /proc/cpuinfo | grep processor | wc -l` + 1))
make -j ${cpunum}

make install

libtool --finish ./libs

a2dismod mpm_worker
a2enmod mpm_prefork
a2enmod php7

systemctl restart apache2
printf "Any errors starting Apache2 with PHP7 can be seen with 'sudo journalctl -xe' .\n"

update-alternatives --install /usr/bin/php php /usr/local/php7/bin/php 50 \
  --slave /usr/share/man/man1/php.1.gz php.1.gz \
  /usr/local/php7/php/man/man1/php.1

printf "Select the version of PHP you want active in subsequent shells and the \
  system:\n"
update-alternatives --config php

## To help enable Apache 2.4 use of PHP 7. Enable this after writing the file.
## /etc/apache2/mods-available/php7.conf
#<FilesMatch ".+\.ph(p[3457]?|t|tml)$">
#    SetHandler application/x-httpd-php
#</FilesMatch>
#<FilesMatch ".+\.phps$">
#    SetHandler application/x-httpd-php-source
#    # Deny access to raw php sources by default
#    # To re-enable it's recommended to enable access to the files
#    # only in specific virtual host or directory
#    Require all denied
#</FilesMatch>
# Deny access to files without filename (e.g. '.php')
#<FilesMatch "^\.ph(p[345]?|t|tml|ps)$">
#    Require all denied
#</FilesMatch>
#
# Running PHP scripts in user directories is disabled by default
#
# To re-enable PHP in user directories comment the following lines
# (from <IfModule ...> to </IfModule>.) Do NOT set it to On as it
# prevents .htaccess files from disabling it.
#<IfModule mod_userdir.c>
#    <Directory /home/*/public_html>
#        php_admin_flag engine Off
#    </Directory>
#</IfModule>"
