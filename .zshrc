# for wsl
# ULIMIT=65536
# if [[ "$(ulimit -n)" != $ULIMIT ]]; then
#     sudo /bin/prlimit --nofile=$ULIMIT:$ULIMIT --pid $$
#     exec /bin/zsh
# fi

# mac
if [ "$(uname -s)" = "Darwin" ]; then
  IS_MACOS="true"
fi


if [[ "$PAGER" == "head -n 10000 | cat" || "$COMPOSER_NO_INTERACTION" == "1" ]]; then
  return
fi

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# pipx
export PATH="$HOME/.local/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/zen.toml)"

# User configuration

# mac
eval "$(/opt/homebrew/bin/brew shellenv)"

# wsl
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# go binary
export PATH="$(go env GOPATH)/bin:$PATH"

if [ ! -z "$IS_MACOS" ]; then
  # gnu tool
  BREW_PREFIX="$(brew --prefix)"
  export PATH="$BREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
  export PATH="$BREW_PREFIX/opt/findutils/libexec/gnubin:$PATH"
  export PATH="$BREW_PREFIX/opt/gnu-tar/libexec/gnubin:$PATH"
  export PATH="$BREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
  export PATH="$BREW_PREFIX/opt/gawk/libexec/gnubin:$PATH"
  export PATH="$BREW_PREFIX/opt/gnu-indent/libexec/gnubin:$PATH"
  export PATH="$BREW_PREFIX/opt/grep/libexec/gnubin:$PATH"

  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  # __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  # if [ $? -eq 0 ]; then
  #     eval "$__conda_setup"
  # else
  #     if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
  #         . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
  #     else
  #         export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
  #     fi
  # fi
  # unset __conda_setup
  # <<< conda initialize <<<
fi

# wsl
# go bin path
# export PATH="$(go env GOPATH)/bin:/home/linuxbrew/.linuxbrew/opt/node@16/bin:${KREW_ROOT:-$HOME/.krew}/bin:$(wslpath $(wslvar USERPROFILE))/AppData/Local/Programs/Microsoft VS Code/bin:$PATH"
# export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/node@16/lib"
# export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/node@16/include"

# python
# export PATH="$HOME/.local/bin:/home/linuxbrew/.linuxbrew/opt/python@3.10/bin:$PATH"
# export PKG_CONFIG_PATH="/home/linuxbrew/.linuxbrew/opt/python@3.10/lib/pkgconfig"

# load aliases
for DOTFILE in `find ${HOME}/.aliases`
do
  [ -f "${DOTFILE}" ] && source "${DOTFILE}"
done

# wsl
# [[ -n "$WT_SESSION" ]] && {
#   chpwd() {
#     echo -en '\e]9;9;"'
#     wslpath -w "$PWD" | tr -d '\n'
#     echo -en '"\x07'
#   }
# }

# wsl
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$($HOME'/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "$HOME/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="$HOME/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
# export PATH="/opt/homebrew/opt/dotnet@8/bin:$PATH"

autoload -U select-word-style
select-word-style bash

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up Arrow
bindkey "^[[B" down-line-or-beginning-search # Down Arrow

source /opt/homebrew/opt/zinit/zinit.zsh

zinit light zdharma-continuum/fast-syntax-highlighting

setopt INTERACTIVE_COMMENTS

# Enable real-time history sharing across all tabs and sessions
setopt SHARE_HISTORY

# Ensure you have a defined history file and limits set
HISTFILE=~/.zsh_history
SAVEHIST=1000000
HISTSIZE=1000000
