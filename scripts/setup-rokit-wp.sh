#!/bin/bash -e

##
# Rokit WP installation script
#
# Description: Installs a Rokt WP (with Rokit WP Theme) instance in your ~/Sites folder
#
# 1) Pulls the needed GIT repo's
# 2) Runs composer update and composer install
# 3) Creates database and prefills it with default setup database
# 4) Renames theme folder and style.css file
# 5) Create's an ENV file
# 6) Installs/runs npm and bower and runs gulp to create the initial assets
#
# Author: Jasper Rooduijn | Rodesk BV
# Dependencies: wp-cli, git, npm, node, gulp, bower
# @TODO Setup viritualhost (https://github.com/RoverWire/virtualhost)
##

# set variables
slug=$1

# Start
echo "#### ROKIT INSTALLER: Beginning Rokit WP Installation... ####"

# Get the name of the folder
read -e -p "Project Name: " slug

if [ -d ~/Sites/$slug ]; then
	echo "#### ROKIT INSTALLER: Folder alreadt exists. Enter other project name... ####"
  	read -e -p "Project Name: " slug
fi

# Set the site path
sitepath=~/Sites/$slug

# accept the URL of project git repo
echo -n "Create a GIT project and enter the url (Use git@ and not https link): "
read gitUrl

# accept the name of our website
echo -n "Enter local url (including http://): "
read localurl

# accept the name of our website
echo -n "Enter database name: "
read dbname

# accept the name of our website
echo -n "Enter database user: "
read dbuser

# accept the name of our website
echo -n "Enter database pass: "
read dbpass

# add a simple yes/no confirmation before we proceed
echo -n "Run Install (Are you shure you want to start)? [y/n] "
read run

# if the user didn't say no, then go ahead an install
if [ "$run" == n ] ; then
exit
else

echo "#### ROKIT INSTALLER: Start running installation for project $slug ####"

# create new directory
echo "#### ROKIT INSTALLER: Create new project folder with name $slug ####"
mkdir $sitepath

# CD into directory
echo "#### ROKIT INSTALLER: The project path is $sitepath... ####"
echo "#### ROKIT INSTALLER: CD into folder $sitepath... ####"
cd $sitepath

# Download Rokit WP from its git directory
# @TODO Check how this work with no SSH keys
echo "#### ROKIT INSTALLER: Clone Rokit WP repo in to project directory... ####"
git clone git@git.rodesk.nl:rodesk-internal/rokit-wp.git $sitepath

# Clean Rokit WP (Remove old git info)
echo "#### ROKIT INSTALLER: Remove old Rokit WP git files... ####"
rm -rf $sitepath/.git

# Duplicate the ENV example file
echo "#### ROKIT INSTALLER: Duplicate the ENV example file... ####"
cp .env.example .env

# Fill the ENV example file with project info
echo "#### ROKIT INSTALLER: Fill ENV file with settings... ####"

sed -i "" "s,database_name,${dbname},g" .env
sed -i "" "s,database_user,${dbuser},g" .env
sed -i "" "s,database_password,${dbpass},g" .env
sed -i "" "s,http://example.com,${localurl},g" .env
sed -i "" "s,http://example.com/cms,${localurl}/cms,g" .env

# Create the database.
echo "#### ROKIT INSTALLER: Creating database $dbname... ####"
mysql -u$dbuser -p$dbpass -e"CREATE DATABASE $dbname"

# Import default setup database.
echo "#### ROKIT INSTALLER: Import setup database into $dbname... ####"
mysql -u$dbuser -p$dbpass -D $dbname < $sitepath/db/setup_db.sql

# Remove import database after importing
echo "#### ROKIT INSTALLER: Remove the sample database and folder... ####"
rm -rf -r db

# Run composer install to install all rokit packages
echo "#### ROKIT INSTALLER: Run 'composer intall' to load all Rokit WP dependencies... ####"
composer install

# Move to themes folder
echo "#### ROKIT INSTALLER: cd to themes folder... ####"
cd $sitepath/web/app/themes/

# Download Rokit WP Theme from its git directory
# @TODO Check how this work with no SSH keys
echo "#### ROKIT INSTALLER: Clone Rokit WP theme repo in to themes directory... ####"
git clone git@git.rodesk.nl:rodesk-internal/rokit-wp-theme.git $slug

# Move to themes folder
echo "#### ROKIT INSTALLER: cd to themes folder... ####"
cd $slug

# Clean theme folder (Remove old git info)
echo "#### ROKIT INSTALLER: Remove Rokit WP Theme git files... ####"
rm -rf .git

# Run composer install to install rokit theme packages
echo "#### ROKIT INSTALLER: Run 'composer intall' to load all Rokit WP dependencies... ####"
composer install

# # Change theme style.css name to project name
echo "#### ROKIT INSTALLER: Change theme name in style.css to $slug... ####"
cd resources
sed -i "" "s/Rokit WP Theme/${slug}/g" style.css
cd ..

# Run npm install inside theme folder
echo "#### ROKIT INSTALLER: Run 'npm install' inside the $themename theme... ####"
npm install

# Run npm install inside theme folder
echo "#### ROKIT INSTALLER: Run 'bower install' inside the $themename theme... ####"
bower install

# Run npm install inside theme folder
echo "#### ROKIT INSTALLER: Run 'Gulp build' inside the $themename theme... ####"
gulp build

# CD back to the root directory
echo "#### ROKIT INSTALLER: CD back to the root directory... ####"
cd $sitepath

# Activate the installed theme
echo "#### ROKIT INSTALLER: activate the correct theme... ####"
themename="$slug/resources"
wp theme activate $themename

# Init local GIT repo
echo "#### ROKIT INSTALLER: Init a local GIT repo for this project ####"
git init

# Add remote GIT origin to project
echo "#### ROKIT INSTALLER: Add remote GIT origin to project ####"
git remote add origin $gitUrl

# Add a first 'Init commit' to the GIT repo and push to remote
echo "#### ROKIT INSTALLER: Add a first 'Init commit' to the GIT repo and push to remote ####"
git add .
git commit -m "Init commit."
git push -u origin master

# Add a develop brach to remote GIT repo
echo "#### ROKIT INSTALLER: Add a develop brach to remote GIT repo ####"
git checkout -b develop
git push --set-upstream origin develop

# Add a stage brach to remote GIT repo
echo "#### ROKIT INSTALLER: Add a stage brach to remote GIT repo ####"
git checkout -b stage
git push --set-upstream origin stage

# Switch back to develop branch
echo "#### ROKIT INSTALLER: Switch back to develop branch ####"
git checkout develop
git push --set-upstream origin stage

# Finalize
echo "#### ROKIT INSTALLER: Installation for project $slug is complete. ####"
echo "#### ROKIT INSTALLER: Please setup the virstual host ${localurl} to the project folder. ####"

fi