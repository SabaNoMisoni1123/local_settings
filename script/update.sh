git -C $XDG_CONFIG_HOME/nvim pull origin master
git -C $LOCAL_SETTINGS pull origin master


case ${OSTYPE} in
  darwin*)
    $LOCAL_BIN/nvim-osx64/bin/nvim --headless +so $XDG_CONFIG_HOME/nvim/init.vim +qa
    ;;
  linux*)
    $LOCAL_BIN/nvim.appimage --headless +so $XDG_CONFIG_HOME/nvim/init.vim +qa
    ;;
esac
