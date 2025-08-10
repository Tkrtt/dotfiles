# Z shell initialization.
# https://github.com/owl4ce/dotfiles

##### GENERAL
# Bat (a cat(1) clone with wings) theme.
export BAT_THEME='base16'

# GPG tty.
export GPG_TTY="${TTY:-$(tty)}"

# Authority delegator.
PRIV="$(command -v doas || command -v sudo)"

##### (OH-MY-)ZSH
# Installation directory path.
export ZSH="${XDG_CONFIG_HOME}/ohmyzsh"

# Theme to load.
ZSH_THEME='ar-round'

# Highlight styling for zsh-autosuggestions.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS='true'

# Disable marking untracked files under VCS as dirty.
DISABLE_UNTRACKED_FILES_DIRTY='true'

# Plugins to load.
plugins=(bgnotify zsh-autosuggestions zsh-completions fast-syntax-highlighting kubectl kubectx docker-compose docker)

# Always append history.
setopt INC_APPEND_HISTORY
HISTFILE="${ZDOTDIR}/zsh_history"

# UNLIMITED HISTORY!!!
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

# Execute OMZ.
source "${ZSH}/oh-my-zsh.sh"

# Speeds up pasting when using zsh-autosuggestions.
# See "https://github.com/zsh-users/zsh-autosuggestions/issues/238".
paste_init()
{
    OLD_SELF_INSERT="${${(s.:.)widgets[self-insert]}[2,3]}"
    zle -N self-insert url-quote-magic
}
paste_done()
{
    zle -N self-insert "$OLD_SELF_INSERT"
}
zstyle :bracketed-paste-magic paste-init paste_init
zstyle :bracketed-paste-magic paste-finish paste_done

##### KEY-BINDINGS
bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word

##### ALIASES
# Hexdump alias.
alias hd='hexdump -C'

# Faster execution alias.
alias q='exit'
alias sudo='sudo '
alias xclipcopy='xclip -selection clipboard <'

# Filesystem TRIM alias.
alias trim_all='${PRIV##*/} fstrim -va'

# Text-editor aliases.
alias crontab='EDITOR=nvim crontab'
alias vim='nvim'

# Page-cache cleaner alias.
alias cleanram="\${PRIV##*/} sh -c 'sync; echo 3 >/proc/sys/vm/drop_caches'"

# Exa (a modern replacement for 'ls') aliases.
if [ -x "$(command -v exa)" ]; then
    alias ls='exa -lgh --icons --group-directories-first'
    alias la='exa -lgha --icons --group-directories-first'
fi

# Bat (a modern replacement for 'cat') aliases.
if [ -x "$(command -v bat)" ]; then
    alias cat='bat'
fi

# Ripgrep
if [ -x "$(command -v rg)" ]; then
    alias grep='rg'
fi

# PACKAGE MANAGEMENT ALIAS
alias yeet='yay -Rsc $(yay -Qttdq)'
alias yoink='yay -Scc'
alias yuck='yay -Rsc'

# SECURITY ALIAS
alias cmplr-unlock='sudo chmod -f 755 /bin/gcc /bin/g++ /bin/clang /bin/go /bin/as'
alias cmplr-lock='sudo chmod -f 700 /bin/gcc /bin/g++ /bin/clang /bin/go /bin/as'

# SSH ALIAS
alias ssh='TERM=linux ssh'

# $HOME cleanup alias
alias yarn='yarn --use-yarnrc ".config/yarn/config"'
alias gnupg='gnupg --homedir ${HOME}/.local/share/gnupg'
alias adb='HOME="$XDG_DATA_HOME/android" adb'
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
alias monerod='monerod --data-dir "$XDG_DATA_HOME/bitmonero"'