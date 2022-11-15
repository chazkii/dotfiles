
if [[ `uname -m` == 'arm64' ]]; then
    echo "Running natively"
    export PATH=/Applications/Julia-1.7.app/Contents/Resources/julia/bin/:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
    export PYENV_ROOT="$HOME/.pyenv"
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
            . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
        else
            export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
        fi
    fi
    unset __conda_setup
# <<< conda initialize <<<
elif [[ `uname -m` == 'x86_64' ]]; then
    echo "Running under Rosetta 2"
    export PYENV_ROOT="$HOME/.pyenv_x86"
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
            . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
        else
            export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
        fi
    fi
    unset __conda_setup
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

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Setting the LG_WEBOS_TV_SDK_HOME variable to the parent directory of CLI
export LG_WEBOS_TV_SDK_HOME="/Users/csmith/Applications/webOS_TV_SDK"
 
if [ -d "$LG_WEBOS_TV_SDK_HOME/CLI/bin" ]; then
  # Setting the WEBOS_CLI_TV variable to the bin directory of CLI
  export WEBOS_CLI_TV="$LG_WEBOS_TV_SDK_HOME/CLI/bin"
  # Adding the bin directory of CLI to the PATH variable
  export PATH="$PATH:$WEBOS_CLI_TV"
fi


