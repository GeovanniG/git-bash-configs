#!/bin/bash

__PS1_BEFORE='\n'
__PS1_TIME='\[\e[30;45m\] [\A] '              # black text, magenta, 24h time
__PS1_USER='\[\e[30;42m\] \u '                  # black text, green, user
__PS1_HOST='\[\e[30;42m\]@\h '                # black text, green, @host
__PS1_LOCATION='\[\e[30;43m\] \w '              # black text, yellow, working director
__PS1_GIT_BRANCH='\[\e[30;46m\]`__git_ps1` '    # black text, cyan, bash function
__PS1_AFTER='\[\e[0m\]\n$ '                     # change color, new line, prompt: always $

__PS1_TEMP=''
if test -z "$WINELOADERNOEXEC"
then
    GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
    COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
    COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
    COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
    if test -f "$COMPLETION_PATH/git-prompt.sh"
    then
        . "$COMPLETION_PATH/git-completion.bash"
        . "$COMPLETION_PATH/git-prompt.sh"
        __PS1_TEMP="${__PS1_GIT_BRANCH}"
    fi
fi

PS1="${__PS1_BEFORE}${__PS1_TIME}${__PS1_USER}${__PS1_LOCATION}${__PS1_TEMP}${__PS1_AFTER}"

# Git status options
# Shows * or + for unstaged and staged changes, respectively.
export GIT_PS1_SHOWSTASHSTATE=true

# shows $ if there are any stashes.
export GIT_PS1_SHOWDIRTYSTATE=true

# Shows % if there are any untracked files.
export GIT_PS1_SHOWUNTRACKEDFILES=true

# shows <, >, <>, or = when your branch is behind, ahead, diverged from,
# or in sync with the upstream branch, respectively.
export GIT_PS1_SHOWUPSTREAM="auto"