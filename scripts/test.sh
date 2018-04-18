#!/bin/bash -e

##
# WordPress Installation and VirtualHost Creation
#
# Description: Installs a WordPress website in the ~/Sites folder, creates a homepage,
# cleans up the WP install a bit, deletes the akismet and hello dolly plugins, creates the permalinks,
# clones the roots/sage theme framework to the theme folder, deletes all the other WP default themes,
# installs/runs npm and bower and runs gulp to create the initial assets, adds a custom gitignore file
# to /wp-content, installs the roots/soil plugin, creates a git repo in wp-content, saves the WordPress
# credentials to a local file and the password to your clipboard. Then it creates a virtualhost for you. Voila!
#
# Author: William Donahoe - @ethicka
#
# Based off of http://www.ltconsulting.co.uk/automated-wordpress-installation-with-bash-wp-cli/
#
# Dependencies: wp-cli, git, npm, node, gulp, bower
#
# Command: wp-start [site-name-slug]
##

# set variables
slug=$1
WPUSER=''
DBUSER=''
DBPASSWORD=''
ADMIN_EMAIL=''

echo "Beginning Rokit WP Installation..."

# Get the name of the folder
read -e -p "Project Name: " slug

# slug='testing'
dbuser='root'
dbpass='twaalfhoog86'
localurl='http://test.dev'

# Set the site path
sitepath=~/Sites/test/$slug # you could change this to wherever you install your sites
if [ ! -d "$sitepath" ]; then
  mkdir $sitepath
fi
cd $sitepath

echo "#### ROKIT INSTALLER: The project path is $sitepath... ####"

# # accept user input for the database name
# echo -n "Enter database password: "
# read dbname

# # accept the name of our website
# echo -n "Enter database user: "
# read dbuser

# # accept the name of our website
# echo -n "Enter database user: "
# read dbpass

# # add a simple yes/no confirmation before we proceed
# echo -n "Run Install (Are you shure WP CLI is installed)? [y/n] "
# read run

# # if the user didn't say no, then go ahead an install
# if [ "$run" == n ] ; then
# exit
# else

# Download Rokit WP from its git directory
# @TODO Check how this work with no SSH keys
echo "#### ROKIT INSTALLER: Clone Rokit WP repo in to project directory... ####"
git clone git@git.rodesk.nl:rodesk-internal/rokit-wp.git $sitepath

# Clean Rokit WP (Remove old git info)
rm -rf $sitepath/.git

# # Create the database.
dbname='local_'$slug
echo "#### ROKIT INSTALLER: Creating database $dbname... ####"
mysql -u$dbuser -p$dbpass -e"CREATE DATABASE $dbname"

# Import default setup database.
echo "#### ROKIT INSTALLER: Import setup database into $dbname... ####"
mysql -u$dbuser -p$dbpass -D $dbname < $sitepath/db/setup_db.sql

# Duplicate the ENV example file
echo "#### ROKIT INSTALLER: Duplicate the ENV example file... ####"
cp .env.example .env

# Fill the ENV example file with project info
echo "#### ROKIT INSTALLER: Fill ENV file with settings... ####"
exmpleurl='http://example.com/'
exmpleurlcs='http://example.com/cms'

sed -i "" "s,database_name,${dbname},g" .env
sed -i "" "s,database_user,${dbuser},g" .env
sed -i "" "s,database_password,${dbpass},g" .env
sed -i "" "s,http://example.com,${localurl},g" .env
sed -i "" "s,http://example.com/cms,${localurl}/cms,g" .env

# Run composer install
echo "#### ROKIT INSTALLER: Run 'composer intall' to load all Rokit WP dependencies... ####"
composer install
composer update

# Rename default theme name to project name
echo "#### ROKIT INSTALLER: Change theme folder name to $sitepath... ####"
cd $sitepath/web/app/themes/
mv rokit-wp-theme $slug


# Clean Rokit theme (Remove old git info)
rm -rf .git

# Change theme style.css name to project name
echo "Creating database $dbname..."
echo "#### ROKIT INSTALLER: Change theme name in style.css to $sitepath... ####"
sed -i "" "s/Rokit WP Theme/${slug}/g" style.css

# Run composer install
echo "#### ROKIT INSTALLER: Run 'composer intall' to load all Rokit WP Theme dependencies... ####"
composer install
composer update

# # Run npm install inside theme folder
# echo "#### ROKIT INSTALLER: Run 'npm install' inside the $slug theme... ####"
# npm install

# # Run npm install inside theme folder
# echo "#### ROKIT INSTALLER: Run 'bower install' inside the $slug theme... ####"
# bower install

# # Run npm install inside theme folder
# echo "#### ROKIT INSTALLER: Run 'gulp' inside the $slug theme... ####"
# gulp

# Setup viritualhost

# Finalize
echo "#### ROKIT INSTALLER: Installation for project $slug is complete. ####"
echo "#### ROKIT INSTALLER: Please setup the virstual host http://${slug}.dev to the project folder. ####"

# fi
