FROM paperist/texlive-ja:debian

USER root
ENV HOME=/root
ENV DEBIAN_FRONTEND=noninteractive
ARG LOCAL_BIN $HOME/.local/app

ENV PYENV_ROOT=$HOME/.pyenv
ENV PATH=$PYENV_ROOT/bin:$PATH
ENV PATH=$PYENV_ROOT/shims:$PATH

RUN apt-get update \
 && apt-get install -y \
    git \
    vim \
    wget \
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
    tk-dev

RUN git config --global http.sslVerify false \
 && git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv \
 && echo 'eval "$(pyenv init -)"' >> $HOME/.bash_profile

RUN pyenv install 3.9.12 \
 && pyenv global 3.9.12

RUN pip install --upgrade pip \
 && pip --no-cache-dir install \
        numpy \
        matplotlib \
        seaborn \
        pandas \
        scikit-learn

RUN apt-get purge -y git wget \
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /root/.config/matplotlib \
 && echo "backend : Agg" > /root/.config/matplotlib/matplotlibrc

WORKDIR $LOCAL_BIN
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
 && chmod +x nvim.appimage \
 && ./nvim.appimage --appimage-extract \
 && curl -fsSL https://deno.land/x/install/install.sh | sh \
 && git clone https://github.com/SK-eee-ku/nvim_setting.git $XDG_CONFIG_HOME/nvim \
 && $LOCAL_BIN/squashfs-root/usr/bin/nvim --headless +so $XDG_CONFIG_HOME/nvim/init.vim +qa
ENV PATH=$LOCAL_BIN/squashfs-root/usr/bin:$PATH

COPY ./*rc /root/
CMD ["/bin/bash"]
