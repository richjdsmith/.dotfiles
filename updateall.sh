# Update App Store apps
sudo softwareupdate -i -a

# Update Homebrew (Cask) & packages (moved to .alias.macos to avoid running as sudo)
brew update
brew upgrade

# Update npm & packages
npm install npm -g
npm update -g

# Update Ruby & gems
sudo gem update —system
sudo gem update