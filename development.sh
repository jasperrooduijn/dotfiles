#!/bin/bash

# Install Gulp
echo "Installing Gulp"
npm install --global gulp-cli

# Install Bower
echo "Installing Bower"
npm install -g bower

# Install Stylelint
echo "Installing Stylelint CLI"
npm install -g stylelint

# Install Node Sass
echo "Installing Node Sass"
npm install -g node-sass

# Install Sass
echo "Installing Sass"
gem install sass

# Install Composer
echo "Installing composer"
brew install composer

# Install PHP
echo "Installing PHP"
brew install php

# Install MariaDB
echo "Installing Mariadb"
brew install mariadb

echo "Run Mariadb on startup/reboot"
brew services start mariadb

# Install mailhog
# To send mail via mailhog edit your php.ini file and add the following
# Add 'sendmail_path = /usr/local/bin/mailhog sendmail test@test' to php.ini file
echo "Installing mailhog"
brew instal mailhog

echo "Run mailhog on startup/reboot"
brew services start mailhog

# Install Laravel Valet-Plus
# https://github.com/weprovide/valet-plus
# brew install php70 --with-homebrew-curl
# brew install php70-xdebug --build-from-source
# composer global require weprovide/valet-plus
# valet install
