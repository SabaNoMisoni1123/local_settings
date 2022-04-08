export SETTING_ROOT=$HOME/linuxSettings
export DOCKER_SETTING_ROOT=$SETTING_ROOT/docker

# zshrc
cp $SETTING_ROOT/.zshrc_docker $DOCKER_SETTING_ROOT/c_env/.zshrc
cp $SETTING_ROOT/.zshrc_docker $DOCKER_SETTING_ROOT/python_env/.zshrc
cp $SETTING_ROOT/.zshrc_docker $DOCKER_SETTING_ROOT/ubuntu_env/.zshrc
cp $SETTING_ROOT/.zshrc_docker $DOCKER_SETTING_ROOT/python_edit_env/.zshrc
cp $SETTING_ROOT/.zshrc_docker $DOCKER_SETTING_ROOT/c_env_edit/.zshrc

# vimrc
cp $SETTING_ROOT/.vimrc $DOCKER_SETTING_ROOT/c_env/
cp $SETTING_ROOT/.vimrc $DOCKER_SETTING_ROOT/python_env/
cp $SETTING_ROOT/.vimrc $DOCKER_SETTING_ROOT/torch_env/
