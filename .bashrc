
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth

shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\u@\h\[\033[00m\]:\[\033[01;35m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias py='python3'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias drma='docker rm -fv $(docker ps -qa)'
alias customscreenkey="screenkey -s large --scr 2 -p bottom --geometry 1210x300+712+810";
alias notes="cd ~/notes/ && nvim"
alias encode=". /home/oscar/.config/scripts/encode.sh"
alias settablet="xsetwacom --set \"12\" MapToOutput HEAD-1; xsetwacom --set \"13\" MapToOutput HEAD-1; xsetwacom --set \"14\" MapToOutput HEAD-1"
alias plz="sudo"
alias please="sudo"
alias wn="python3 ~/.config/scripts/whatnext.py"
alias nc="cd Code/work/nightcrawler"

wp() {
    feh --bg-scale "$1"
}

nwt() {
    if [ -z "$1" ]; then
        echo "Usage: nwt <branch-name>"
        return 1
    fi

    local folder_name="${1//\//-}"

    git fetch
    git worktree add "../$folder_name" "$1"
    cd "../$folder_name" || return
}

rmwt() {
    if [ -z "$1" ]; then
        echo "Usage: rmwt <branch-name>"
        return 1
    fi

    local folder_name="${1//\//-}"

    git worktree remove "../$folder_name"
}

gfch() {
    if [ -z "$1" ]; then
        ehco "Usage: gfch"
    fi

    git fetch
    git checkout "$1"
}

setup() {
    local which="$1"
    local branch_name="$2"

     if [[ "$which" == "nightcrawler" ]]; then
         setup-nightcrawler $branch_name
     elif [[ "$which" == "cg" ]]; then
         setup-choreographd $branch_name
     else
         echo "Usage: setup <repo> <pre-created-branch>"
     fi
}

setup-nightcrawler() {
    local branch_name="$1"
    
    if [[ -z "$branch_name" ]]; then
        echo "Error: Please provide a branch name."
        return 1
    fi

    local folder_name="${branch_name//\//-}"
    local repo_path="$HOME/Code/work/nightcrawler"
    local worktree_path="$HOME/Code/work/nightcrawler-worktrees/$folder_name"

    echo "Creating worktree for branch '$branch_name' at $worktree_path..."
    git -C "$repo_path" fetch
    git -C "$repo_path" worktree add "$worktree_path" "$branch_name"

    if [[ ! -f "$worktree_path/frontend/.env" ]]; then
        cp ~/Code/work/nightcrawler-worktrees/.shared-env "$worktree_path"/apps/site/.env
        cp ~/Code/work/nightcrawler-worktrees/.shared-env "$worktree_path"/packages/db/.env
    fi

    if [[ -d "$worktree_path" ]]; then
        kitty @ launch --type=os-window --window-title "codex @ $branch_name" --cwd="$worktree_path" --hold codex
        
        kitty @ launch --type=tab --tab-title "dev" --cwd="$worktree_path" --hold nvim
        
        kitty @ launch --type=tab --tab-title "bun run dev" --cwd="$worktree_path/apps/site" --hold bun i && bun run dev

        kitty @ launch --type=tab --tab-title "commands" --cwd="$worktree_path/apps/site" --hold  

        exit
    else
        echo "Error: Worktree directory was not created."
        return 1
    fi
}

setup-choreographd() {
    local branch_name="$1"
    
    if [[ -z "$branch_name" ]]; then
        echo "Error: Please provide a branch name."
        return 1
    fi

    local folder_name="${branch_name//\//-}"
    local repo_path="$HOME/Code/general-projects/choreographd"
    local worktree_path="$HOME/Code/general-projects/choreographd-worktrees/$folder_name"

    echo "Creating worktree for branch '$branch_name' at $worktree_path..."
    git -C "$repo_path" fetch
    git -C "$repo_path" worktree add "$worktree_path" "$branch_name"

    if [[ ! -f "$worktree_path/.env" ]]; then
        cp ~/Code/general-projects/choreographd/.shared-env "$worktree_path"/.env
    fi

    if [[ -d "$worktree_path" ]]; then
        kitty @ launch --type=os-window --window-title "ai @ $branch_name" --cwd="$worktree_path" --hold pi 
        
        kitty @ launch --type=tab --tab-title "nvim" --cwd="$worktree_path" --hold nvim
        
        kitty @ launch --type=tab --tab-title "live" --cwd="$worktree_path" --hold bun i && bun run dev

        kitty @ launch --type=tab --tab-title "cmds" --cwd="$worktree_path" --hold  

        exit
    else
        echo "Error: Worktree directory was not created."
        return 1
    fi
}

alias gwtp="git worktree prune"

export EDITOR="nvim"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/home/oscar/.spicetify
export PATH=$PATH:/home/oscar/.local/bin/
alias config='/usr/bin/git --git-dir=/home/oscar/.cfg/ --work-tree=/home/oscar'

export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init bash)"

PATH="/home/oscar/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/oscar/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/oscar/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/oscar/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/oscar/perl5"; export PERL_MM_OPT;
