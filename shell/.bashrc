# Need to install the command line tools first using:
#   xcode-select --install

GIT_UTILS=/Library/Developer/CommandLineTools/usr/share/git-core/
LOCAL_BIN=/usr/local/bin

# Fancy diffs for non git files.
dsf() {
  git diff --no-index --color "$@" | diff-so-fancy | less --tabs=4 -R
}

# Add colours to man pages
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# Add git info to the prompt
git_prompt () {
  __git_ps1 "\W" "\\\$ "
}

PATH=~/bin:$PATH

export HISTCONTROL=ignoredups
export HISTSIZE=50000
export HISTFILESIZE=50000

export EDITOR='subl -w'

# Setup nvm to manage node versions
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Command line colours
export CLICOLOR=1

# Colours for less
export LESSOPEN="| $LOCAL_BIN/src-hilite-lesspipe.sh %s"
export LESS=' -RXF '

# Git PS1 config and command completion
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1

source $GIT_UTILS/git-completion.bash
source $GIT_UTILS/git-prompt.sh

PROMPT_COMMAND="git_prompt ; $PROMPT_COMMAND"
