
if [[ `uname -m` == 'arm64' ]]; then
    echo "Running natively"
    export PATH=/Applications/Julia-1.7.app/Contents/Resources/julia/bin/:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
    export PYENV_ROOT="$HOME/.pyenv"
elif [[ `uname -m` == 'x86_64' ]]; then
    echo "Running under Rosetta 2"
    export PYENV_ROOT="$HOME/.pyenv_x86"
else
    echo "not a recognised arch! $(uname -m)"
fi

export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# Mac only
alias ls='ls -G'
alias ll='ls -lG'

eval "$(rbenv init - zsh)"
