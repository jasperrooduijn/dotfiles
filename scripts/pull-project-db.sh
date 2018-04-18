#!/bin/bash -e

##
# Set web direcotry fulder rights and user group
#

# set variables
slug=${PWD##*/}
path=~/Sites/$slug

# Start
echo "#### ROKIT FOLDER RIGHTS: Beginning to pull DB... ####"

echo "#### ROKIT FOLDER RIGHTS: Project: $slug"

echo "#### ROKIT FOLDER RIGHTS: Path: $path"

echo "#### ROKIT FOLDER RIGHTS: Disable Polylang Pro plugin"

wp plugin deactivate polylang-pro

echo "#### ROKIT FOLDER RIGHTS: Disable Theme Translation for Polylang plugin"

wp plugin deactivate theme-translation-for-polylang

# Finalize
echo "#### ROKIT ROKIT FOLDER RIGHTS: Done. ####"
