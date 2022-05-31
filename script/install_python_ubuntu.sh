mkdir $XDG_CONFIG_HOME

sudo apt -y install \
  git \
  build-essential \
  libbz2-dev \
  libdb-dev \
  libreadline-dev \
  libffi-dev \
  libgdbm-dev \
  liblzma-dev \
  libncursesw5-dev \
  libsqlite3-dev \
  libssl-dev \
  zlib1g-dev \
  uuid-dev \
  tk-dev \

git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
pyenv install 3.10.4
pyenv global 3.10.4
source $HOME/.zshrc
pip install -r $LOCAL_SETTINGS/python/pip_edit.txt
pip install -r $LOCAL_SETTINGS/python/pip_standard.txt

cp $LOCAL_SETTINGS/xdg_config_home/pycodestyle $XDG_CONFIG_HOME/
