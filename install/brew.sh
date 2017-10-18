brew tap Goles/battery
brew update
brew upgrade

# Install packages

apps=(
  bash-completion2
  battery
  coreutils
  diff-so-fancy
  git
  git-extras
  gnu-sed --with-default-names
  grep --with-default-names
  hub
  httpie
  imagemagick
  mackup
  pandoc
  python3
  tree
  unar
  wget
  wifi-password
)

brew install "${apps[@]}"

export DOTFILES_BREW_PREFIX_COREUTILS=`brew --prefix coreutils`
set-config "DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_CACHE"

ln -sfv "$DOTFILES_DIR/etc/mackup/.mackup.cfg" ~