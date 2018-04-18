#!/bin/bash -e

##
# Run the packages scripts on packages.rodeskstudio.com to update satis
#

# Start
echo "#### ROKIT FOLDER RIGHTS: SSH into the Rodeskstudio packages server... ####"
echo "#### ROKIT FOLDER RIGHTS: Run the SU command to get sudo rights... ####"
echo "#### ROKIT FOLDER RIGHTS: Run the Satis update script... ####"

ssh -t admin@rodeskstudio.nl "cd ../../scripts; sudo bash update-satis.sh;"

# Finalize
echo "#### ROKIT ROKIT FOLDER RIGHTS: Done finished updating. ####"
