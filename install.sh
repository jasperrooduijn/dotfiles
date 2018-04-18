#!/bin/sh

echo "Setting up your Mac..."

## Install devtools
xcode-select --install

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
    echo "Installing Homebrew."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Create an NVM directory
mkdir $HOME/.nvm

# Create a Sites directory
# This is a default directory for OS X user accounts but doesn't comes pre-installed
mkdir $HOME/Sites

# Set execute permission on development script and runs development script
# Setup development dependencies
chmod +x development.sh
sh development.sh

# Set execute permission on symlink script and runs symlink script
# Symlinks any specified 'dofiles' to '~/'
chmod +x symlink.sh
sh symlink.sh

# Install Sketchtool
chmod +x sketchtool.sh
sh sketchtool.sh

# Set macos preferences
# We will run this last because this will reload the shell
source .macos

# Install oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Make ZSH the default shell environment
# chsh -s $(which zsh)
sudo dscl . -create /Users/$USER UserShell $(which zsh)

# TODO
# Sync SSH key
# Install and sync back from mackup
# Resync backup script maken voor folders (Fonts, Sites, Bureaublad, Keychains, mysql)