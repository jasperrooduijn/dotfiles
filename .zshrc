# Load the shell dotfiles
# * ~/.aliases can be used to extend aliases.
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used to stash provate data (logins eg). Ignored by GIT
for file in ~/.{aliases,path,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

# To install powerline font follow the four steps below
# step 1: Run in terminal 'git clone https://github.com/powerline/fonts'
# step 2: Run in terminal 'cd fonts'
# step 3: Run in terminal 'sh install.sh'
# step 4: Open iTerm2->Preferences->Profiles->Change Font-> 12pt Meslo LG S DZ Regular for Powerline

ZSH_THEME="agnoster"
DEFAULT_USER=`whoami`

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git jump sublime command-not-found common-aliases composer.plugin shrink-path)

# Path to your oh-my-zsh installation.
export ZSH=/Users/jasperrooduijn/.oh-my-zsh

# Path to your oh-my-zsh installation.
source $ZSH/oh-my-zsh.sh

# For a fish-style working directory in your command prompt
# Uses the ZSH shrink-path plugin
# setopt prompt_subst
# PS1= blue black '%n@%m $(shrink_path -f)>'

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Load some homebrew ZSH plugins
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fpath=(/usr/local/share/zsh-completions $fpath)

# Load the correct path for Node Version Manager
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh # This loads nvm
