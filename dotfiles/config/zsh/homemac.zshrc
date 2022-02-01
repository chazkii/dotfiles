# Trying to get things working on new mac
export PATH=/Applications/Julia-1.7.app/Contents/Resources/julia/bin/:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# Mac only
alias ls='ls -G'
alias ll='ls -lG'

eval "$(rbenv init - zsh)"
