# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

# Show git branch when in a git repo
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}
export PS1='\[\033[0;32m\]\w\[\033[0;33m\]$(parse_git_branch)\[\033[00m\] $ '

export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
export ANT_HOME=""

alias 10='cd ~/Projects/10gen'
alias mms='cd ~/Projects/10gen/mms/server'
alias til='cd ~/Projects/til'
alias data='cd /data'
alias scripts='cd ~/Projects/10gen/mms/scripts'
alias agents='cd ~/Projects/10gen/agents'
alias agents.kill='pgrep mms | xargs kill'
alias agents.clean='rm -rf ~/Projects/10gen/agents/*'
alias ngrok.start='cd ~/Downloads && ./ngrok http -subdomain=mongodb-cloud-calin 8080'
alias db.start='~/Projects/10gen/mms/scripts/./mongodb-start-standalone.bash -p 27017'
alias getip='wget http://ipinfo.io/ip -qO -'

alias mhub='cat ~/.mongo-links.txt'

mms-purge() {
ant mms.reset.local &&
    ant assets.clear.cache &&
    ant clean &&
    sudo rm -rf /data/* &&
    sudo mkdir -p /data/backups/daemon &&
    sudo chown `whoami` /data/backups/daemon &&
    rm -rf ~/Projects/10gen/agents/* &&
    pgrep mongo | xargs kill &&
    pgrep mongod | xargs kill &&
    sudo rm -rf /var/lib/mongodb-mms-automation &&
    sudo rm -rf /var/log/mongodb-mms-automation &&
    ant mms.reset.local &&
    ant assets.clear.cache &&
    ant clean
}

mms-rebuild() {
~/Projects/10gen/mms/scripts/./mongodb-start-standalone.bash -p 27017 &&
    ant mms.init.local &&
    ant mms.server.local
}

mms-start() {
cd ~/Projects/10gen/mms/scripts &&
    ./mongodb-start-standalone.bash -p 27017 &&
    cd ~/Projects/10gen/mms/server &&
    ant init.dev &&
    ant mms.server.local -Dskip.assets=true &
}

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi
