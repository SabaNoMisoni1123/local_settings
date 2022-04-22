FROM python:3.9.10

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
RUN apt-get update \
 && apt-get -y install locales \
 && localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 \
 && echo 'set bell-style none' >> /root/.inputrc \
 && apt-get -y install zsh vim \
 && pip install --upgrade pip \
 && pip install --upgrade setuptools \
 && pip install neovim

WORKDIR $LOCAL_BIN
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
 && chmod +x nvim.appimage \
 && ./nvim.appimage --appimage-extract \
 && curl -fsSL https://deno.land/x/install/install.sh | sh \
 && git clone https://github.com/SK-eee-ku/nvim_setting.git $XDG_CONFIG_HOME/nvim \
 && $LOCAL_BIN/squashfs-root/usr/bin/nvim --headless +so $XDG_CONFIG_HOME/nvim/init.vim +qa
ENV PATH=$LOCAL_BIN/squashfs-root/usr/bin:$PATH

COPY ./.*rc $HOME/
CMD ["/bin/zsh"]
