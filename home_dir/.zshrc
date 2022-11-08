export LOCAL_BIN="$HOME/.local/app"
export LOCAL_SETTINGS="$HOME/local_settings"
source $LOCAL_SETTINGS/.zshrc

export GHOME="/path/to/google drive"
export MEMO_DIR=$GHOME/memo
export DROPBOX_HOME="/path/to/dropbox"
export RESEARCH_HOME=$DROPBOX_HOME/ku_research

alias cdg='cd $GHOME'
alias cdt="cd $HOME/workspace/test"
alias cdn="cd $XDG_CONFIG_HOME/nvim"

# wsl
# setting for xserver
# umask 022
# export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
