FROM ubuntu

USER root
ENV HOME=/root
ENV DEBIAN_FRONTEND=noninteractive
ENV LOCAL_BIN=$HOME/.local/app

ENV XDG_CONFIG_HOME=$HOME/.config
ENV XDG_CACHE_HOME=$HOME/.cache
ENV XDG_RUNTIME_DIR=$HOME/.cache/runtime
ENV DENO_INSTALL=$HOME/.deno
ENV PATH=$PATH:$DENO_INSTALL/bin
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV TZ=JST-9
ENV TERM=xterm

WORKDIR $HOME
RUN apt-get -y update  \
 && apt-get -y install locales tzdata \
 && localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 \
 && apt -y install \
    build-essential \
    zsh \
    unzip \
    wget \
    curl \
    git \
    libssl-dev \
    clang \
    clang-tools \
    clangd-12 \
 && update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-12 100

WORKDIR $LOCAL_BIN
RUN wget https://github.com/Kitware/CMake/releases/download/v3.23.0/cmake-3.23.0-linux-x86_64.tar.gz \
 && tar xvf cmake-3.23.0-linux-x86_64.tar.gz \
 && rm cmake-3.23.0-linux-x86_64.tar.gz
ENV PATH=$LOCAL_BIN/cmake-3.23.0-linux-x86_64/bin:$PATH

WORKDIR $LOCAL_BIN
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
 && chmod +x nvim.appimage \
 && ./nvim.appimage --appimage-extract \
 && curl -fsSL https://deno.land/x/install/install.sh | sh \
 && git clone https://github.com/SK-eee-ku/nvim_setting.git $XDG_CONFIG_HOME/nvim \
 && $LOCAL_BIN/squashfs-root/usr/bin/nvim --headless +so $XDG_CONFIG_HOME/nvim/init.vim +qa
ENV PATH=$LOCAL_BIN/squashfs-root/usr/bin:$PATH

RUN apt-get -y purge tzdata unzip wget curl git \
 && apt-get -y autoremove \
 && rm -rf /var/lib/apt/lists/*

WORKDIR $HOME
COPY ./.*rc $HOME/
CMD ["/bin/zsh"]
