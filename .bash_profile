#!/bin/bash
#THIS MUST BE AT THE END OF THE FILE FOR 

export FIRST_NAME="Madhur"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_121.jdk/Contents/Home

#To quickly run without any tests or regenerate domain classes for contract changes
alias quick-install="mvn clean install -DskipTests -P'!local-server'"
alias dependency-tree='mvn dependency:tree'
alias no-merge='git branch -r --no-merge'
 
alias fif='find-in-files'
alias fiaf='find-in-all-files'
 
find-in-files() {
    FILE_PATTERN=$1
    GREP_PATTERN=$2
    if [ "$FILE_PATTERN" == "" ]; then
        echo "usage: find-in-files [FILENAME_PATTERN] GREP_PATTERN"
        return
    fi
 
    if [ "$GREP_PATTERN" == "" ]; then
        GREP_PATTERN="$FILE_PATTERN"
        FILE_PATTERN="*"
    fi
 
    find . -name "$FILE_PATTERN" -and -not -path "*/.svn/*" -and -not -path "*/target/*" -exec grep -nis "$GREP_PATTERN" {} echo \;
}
 
find-in-all-files() {
    GREP_PATTERN=$1
    if [ "$GREP_PATTERN" == "" ]; then
        echo "usage: find-in-all-files GREP_PATTERN"
        return
    fi
 
    find-in-files "$GREP_PATTERN"
}
 
format-json() {
    FILE=$1
    if [ "$FILE" == "" ]; then
        echo "usage: format-json json_file"
        return
    fi
 
    python -mjson.tool "$FILE" > /tmp/format-json.json
    mv /tmp/format-json.json "$FILE"
}
  
#note: the next line assumes your git repo for the team-bin project is in ~/Code
source ~/code/dcd-scripts/bash-config

export PATH=$PATH:~/Code/tx-audio-clips:~/Code/team-bin/scripts
export TX_DIR=~/Code/tx-audio-clips

#change tab color in iTerm2
function color {
    case $1 in
    green)
    echo -e "\033]6;1;bg;red;brightness;57\a"
    echo -e "\033]6;1;bg;green;brightness;197\a"
    echo -e "\033]6;1;bg;blue;brightness;77\a"
    ;;
    red)
    echo -e "\033]6;1;bg;red;brightness;270\a"
    echo -e "\033]6;1;bg;green;brightness;60\a"
    echo -e "\033]6;1;bg;blue;brightness;83\a"
    ;;
    orange)
    echo -e "\033]6;1;bg;red;brightness;227\a"
    echo -e "\033]6;1;bg;green;brightness;143\a"
    echo -e "\033]6;1;bg;blue;brightness;10\a"
    ;;
    esac
 }

# Git branch in prompt.
function prompt {
  local BLACK="\[\033[0;30m\]"
  local BLACKBOLD="\[\033[1;30m\]"
  local RED="\[\033[0;31m\]"
  local REDBOLD="\[\033[1;31m\]"
  local GREEN="\[\033[0;32m\]"
  local GREENBOLD="\[\033[1;32m\]"
  local YELLOW="\[\033[0;33m\]"
  local YELLOWBOLD="\[\033[1;33m\]"
  local BLUE="\[\033[0;34m\]"
  local BLUEBOLD="\[\033[1;34m\]"
  local PURPLE="\[\033[0;35m\]"
  local PURPLEBOLD="\[\033[1;35m\]"
  local CYAN="\[\033[0;36m\]"
  local CYANBOLD="\[\033[1;36m\]"
  local WHITE="\[\033[0;37m\]"
  local WHITEBOLD="\[\033[1;37m\]"
  local RESETCOLOR="\[\e[00m\]"

  export PS1="\u@[$CYAN\w$RESETCOLOR]$RESETCOLOR$GREENBOLD\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/') $RESETCOLOR"
  #export PS2=" | → $RESETCOLOR"
}

prompt

function parse_git_branch {
         git branch 2> /Code/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
#PS1="\u@\h:\W\$(parse_git_branch)$ "; export PS1

alias la='ls -la'
alias ll='ls -lrt'
alias stash='git stash'
alias pop='git stash pop'
alias gs='git status'
alias co-dev='git checkout develop && git pull'
alias co-master='git checkout master && git pull'
alias release='mvn clean release:prepare release:perform -B'
alias snapshot='mvn clean deploy'
alias commit='git commit -am'
alias prettyLog='git log --pretty=format:"%an %cr:(%h) %s" --graph'
alias yda='youtube-dl -x --audio-format wav'
alias update-pass='groovy ~/dev/team-bin/scripts/crowdPasswordUpdate.groovy'
alias git-history="git for-each-ref --format='%(committerdate) %09 %(authorname) %09 %(refname)'| sort -k5n -k2M -k3n -k4n"
alias gco='git checkout'
alias gallery-build='gradle clean build'
alias npm-rb='npm run build'
alias npm-rw='npm run watch'
alias clear-commit='git reset --hard HEAD^'
alias pull='git pull'

branch () {
  git checkout -b $1
  git push -u --no-verify origin $1
}

delete-branch () {
  git checkout master
  git branch -d $1
  git push origin --delete $1
}


