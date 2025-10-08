# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# bindkey
autoload -Uz edit-command-line
zle -N edit-command-line

bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M viins '^v' edit-command-line
bindkey -M vicmd '^v' edit-command-line
bindkey -M viins '^l' accept-line
bindkey -M vicmd '^l' accept-line
EDITOR='nvim'

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# git
function rprompt-git-current-branch {
local branch_name st branch_status

if [ ! -e ".git" ]; then
return
fi
branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
st=`git status 2> /dev/null`
if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
branch_status="%F{green}"
elif [[ -n `echo "$st" | grep -E "^追跡されていないファイル:|^Untracked files"` ]]; then
branch_status="%F{red}?"
elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
branch_status="%F{red}+"
elif [[ -n `echo "$st" | grep -E "^コミット予定の変更点:|^Changes to be committed"` ]]; then
branch_status="%F{yellow}!"
elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
echo "%F{red}!(no branch)"
return
else
branch_status="%F{blue}"
fi
echo "${branch_status}[$branch_name]"
}

setopt prompt_subst
RPROMPT='`rprompt-git-current-branch`'

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

# 環境変数
export LANG=ja_JP.UTF-8

export TERM=screen-256color
set termguicolors

# alias設定
alias vi='nvim'
alias tm='tmux'
alias ga='git add'
alias gc='git commit'
alias gp='git push -u'
alias gl='git log'
alias gs='git status'
alias vf='nvim $(fzf)'
alias cdf='find . -name "*" -type d | fzf'

alias vz='nvim ~/.zshrc'
alias vzl='nvim ~/.zshrc_local'
alias sz='source ~/.zshrc'
alias vv='nvim ~/.config/nvim/init.lua'
alias memo='vi ~/Documents/memo.txt'
# CircleCiCLI用alias
alias civa='circleci config validate'
alias cile='circleci local execute'

# .zsh_local読み込み
[ -f $HOME/.zshrc_local ] && source $HOME/.zshrc_local

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

case ${OSTYPE} in
  darwin*)
    ;;
  linux*)
    alias auau='sudo apt update && sudo apt upgrade -y'

    eval "$(dircolors -b)"
    autoload -U +X bashcompinit && bashcompinit
    complete -o nospace -C /home/ya/.anyenv/envs/tfenv/versions/1.2.8/terraform terraform
    ;;
esac
