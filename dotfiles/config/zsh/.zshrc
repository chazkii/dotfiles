[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# https://thevaluable.dev/zsh-install-configure/

source ~/dotfiles/dotfiles/aliases

# Auto complete
autoload -Uz compinit; compinit
_comp_options+=(globdots) # With hidden files
source $ZDOTDIR/completion.zsh

# Activating vi mode
bindkey -v
# https://superuser.com/questions/351499/how-to-switch-comfortably-to-vi-command-mode-on-the-zsh-command-line
bindkey -M viins 'kj' vi-cmd-mode
# timeout in ms - need relatively high to make kj work faster
export KEYTIMEOUT=20

# Changing cursor
cursor_mode() {
    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}

cursor_mode

# Bash completion (do not autofill characters when pressing tab)
setopt noautomenu
setopt nomenucomplete

# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $ZDOTDIR/homemac.zshrc
source $ZDOTDIR/manahl.zshrc
