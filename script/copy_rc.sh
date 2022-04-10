export DOCKER_SETTING_ROOT=$LOCAL_SETTINGS/docker

# zshrc
cp $LOCAL_SETTINGS/.zshrc_docker $LOCAL_SETTINGS/docker/c_env/.zshrc
cp $LOCAL_SETTINGS/.zshrc_docker $LOCAL_SETTINGS/docker/python_env/.zshrc
cp $LOCAL_SETTINGS/.zshrc_docker $LOCAL_SETTINGS/docker/ubuntu_env/.zshrc
cp $LOCAL_SETTINGS/.zshrc_docker $LOCAL_SETTINGS/docker/python_edit_env/.zshrc
cp $LOCAL_SETTINGS/.zshrc_docker $LOCAL_SETTINGS/docker/c_env_edit/.zshrc

# vimrc
cp $LOCAL_SETTINGS/.vimrc $LOCAL_SETTINGS/docker/c_env/
cp $LOCAL_SETTINGS/.vimrc $LOCAL_SETTINGS/docker/python_env/
cp $LOCAL_SETTINGS/.vimrc $LOCAL_SETTINGS/docker/torch_env/
