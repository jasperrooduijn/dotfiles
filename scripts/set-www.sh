#!/bin/bash -e

##
# Set web direcotry fulder rights and user group
#

# set variables
slug=${PWD##*/}
path=~/Sites/$slug

# Start
echo "#### ROKIT FOLDER RIGHTS: Beginning to set folder rights... ####"

echo "#### ROKIT FOLDER RIGHTS: Project: $slug"

echo "#### ROKIT FOLDER RIGHTS: Path: $path"

sudo chown -R _www:_www $path

sudo chmod -R g+w $path

# Finalize
echo "#### ROKIT ROKIT FOLDER RIGHTS: Folder rights for $slug is complete. ####"
