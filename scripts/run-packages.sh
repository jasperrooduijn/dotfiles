#!/bin/bash -e

##
# Run the packages scripts on composer.rodeskpackages.nl to update satis
#

# Start
echo "#### SSH into the Rodesk packages server... ####"
echo "#### Run the Satis update script... ####"

ssh rodesk@178.62.202.239 "cd /var/www/composer.rodeskpackages.nl/public_html; satis/bin/satis build satis.json /var/www/composer.rodeskpackages.nl/public_html;"

# Finalize
echo "#### Done. finished updating. ####"
