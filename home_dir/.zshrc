export LOCAL_BIN="$HOME/.local/app"
export LOCAL_SETTINGS="$HOME/local_settings"
source $LOCAL_SETTINGS/.zshrc

export GHOME="/path/to/google drive"
export MEMO_DIR=$GHOME/memo
export DROPBOX_HOME="/mnt/d/skond/Dropbox_Mlab/Dropbox (MLab)/"
export RESEARCH_HOME=$DROPBOX_HOME/ku_research

alias cdg='cd $GHOME'

# wsl
# setting for xserver
# umask 022
# export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
