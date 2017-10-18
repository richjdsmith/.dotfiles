# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";
# If not running interactively, don't do anything

[ -z "$PS1" ] && return

# Resolve DOTFILES_DIR (assuming ~/.dotfiles on distros without readlink and/or $BASH_SOURCE/$0)

READLINK=$(which greadlink || which readlink)
CURRENT_SCRIPT=$BASH_SOURCE


if [[ -n $CURRENT_SCRIPT && -x "$READLINK" ]]; then
  SCRIPT_PATH=$($READLINK -f "$CURRENT_SCRIPT")
  DOTFILES_DIR=$(dirname "$(dirname "$SCRIPT_PATH")")
elif [ -d "$HOME/.dotfiles" ]; then
  DOTFILES_DIR="$HOME/.dotfiles"
else
  echo "Unable to find dotfiles, exiting."
  return
fi

# Read cache

DOTFILES_CACHE="$DOTFILES_DIR/.cache.sh"
[ -f "$DOTFILES_CACHE" ] && . "$DOTFILES_CACHE"

# Finally we can source the dotfiles (order matters)

for DOTFILE in "$DOTFILES_DIR"/system/.{function,function_*,path,env,alias,completion,grep,prompt,rvm}; do
  [ -f "$DOTFILE" ] && . "$DOTFILE"
done

# Dotfiles if on MacOS. Comment out if not.
for DOTFILE in "$DOTFILES_DIR"/system/.{env,alias,function}.macos; do
[ -f "$DOTFILE" ] && . "$DOTFILE"
done


# Set LSCOLORS #

# Load GNU aliases
# source /usr/local/Cellar/coreutils/*/aliases
# Alias ls to GNUs alias
# alias ls='gls --color=auto'


eval "$(gdircolors "$DOTFILES_DIR"/system/.dir_colors)"

function _update_ps1() {
    PS1="$(powerline-shell $?)"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi


# Clean up

unset READLINK CURRENT_SCRIPT SCRIPT_PATH DOTFILE EXTRAFILE

# Export

export DOTFILES_DIR DOTFILES_EXTRA_DIR


