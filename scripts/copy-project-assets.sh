#!/bin/bash -e

##
# Rokit WP installation script
#
# Description: Copy Rokit project assets from one folder to another
#
# 1) Pulls the needed GIT repo's
#
# Author: Jasper Rooduijn | Rodesk BV
# Dependencies: wp-cli, git, npm, node, gulp, bower
##

# set variables
slug=$1

# Start
echo "#### ROKIT ASSET COPY: Beginning to copy project assets ... ####"

# Get the name of the source projcect
read -e -p "Path to source project: " source

# Get the name of the source project
read -e -p "Path to destination project: " dest

# CD to dest project

# Finalize
echo "#### ROKIT ASSET COPY: Copy source assets is complete. ####"
