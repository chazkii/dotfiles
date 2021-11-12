export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# Mac only
alias ls='ls -G'
alias ll='ls -lG'

eval "$(rbenv init - zsh)"


