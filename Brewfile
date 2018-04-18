# To maintain cask
#     brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup`

# Make sure apps get installed in system Application dir
cask_args appdir: '/Applications'

# Install native apps
tap 'caskroom/cask'
tap 'caskroom/fonts'
tap 'homebrew/dupes'
tap 'caskroom/versions'
tap 'homebrew/bundle'
tap 'homebrew/php'
tap 'caskroom/drivers'

# tap 'homebrew/php'

# Install ZSH
# @TODO Check all ZSH plugins to see if they can be installed
brew 'zsh'
brew 'zsh-completions'
brew 'zsh-autosuggestions'
brew 'zsh-syntax-highlighting'

# Install GNU core utilities (those that come with macOS are outdated)
brew 'coreutils'

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew 'findutils'

# Install Bash 4
brew 'bash'

# Install more recent versions of some macOS tools
# brew 'homebrew/dupes/grep'
brew 'grep'

# Install Binaries
brew 'git'
brew 'node' # This installs `npm` too using the recommended installation method
brew 'nvm'
brew 'ruby'
brew 'trash'
brew 'wget'
brew 'curl' , args: ["with-openssl"]

# Browsers
cask 'firefox'
cask 'google-chrome'

# Design
cask 'sketch'

# Dev
cask 'tower'
cask 'iterm2'
cask 'postman'
cask 'sequel-pro'
cask 'poedit'
brew 'composer'

# Utility
cask 'flux'
cask 'macdown'
cask 'the-unarchiver'
cask 'unrarx'
cask '1password'
cask 'alfred'
cask 'appzapper'
cask 'bartender'
cask 'dash'
cask 'delibar'
cask 'tunnelblick'
cask 'fontbase'

# Communication
cask 'slack'
cask 'telegram-desktop'
cask 'whatsapp'
cask 'skype'

# Editors
cask 'sublime-text'
cask 'macdown'
cask 'openoffice'
cask 'visual-studio-code'

# Other
cask 'spotify'
cask 'vlc'
cask 'transmission'
cask 'wacom-intuos-tablet'

# Instal Mac Appstore Store CLI command
mas "Airmail", id: 918858936
mas "WeatherPro", id: 966486618
mas "Wunderlist", id: 410628904
mas "Trello", id: 1278508951
mas "Reeder 3", id: 880001334
mas "Garmin BaseCamp", id: 411052274

# Install manually
# Transmit
# Adobe suite
# Stack app
# Google Calender (make app from it with https://applicationize.me/)