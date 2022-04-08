FROM ubuntu
USER root

USER root
ENV HOME=/root
ENV DEBIAN_FRONTEND=noninteractive

ENV XDG_CONFIG_HOME $HOME/.config
ENV XDG_CACHE_HOME $HOME/.cache
ENV XDG_RUNTIME_DIR $HOME/.cache/runtime
ENV DENO_INSTALL $HOME/.deno
ENV PATH $PATH:$DENO_INSTALL/bin
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV TZ JST-9
ENV TERM xterm

WORKDIR $HOME
RUN apt-get -y update  \
 && apt-get -y install \
                locales \
                tzdata \
                zsh \
                curl \
                wget \
                unzip \
                git \
 && localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 \
 && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

WORKDIR $HOME/appimages
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
 && chmod +x nvim.appimage \
 && ./nvim.appimage --appimage-extract \
 && curl -fsSL https://deno.land/x/install/install.sh | sh \
 && git clone https://github.com/SK-eee-ku/nvim_setting.git $XDG_CONFIG_HOME/nvim
ENV PATH $HOME/appimages/squashfs-root/usr/bin:$PATH

RUN apt-get -y purge tzdata unzip wget curl git \
 && apt-get -y autoremove \
 && rm -rf /var/lib/apt/lists/*

COPY ./.*rc $HOME/
CMD ["/bin/zsh"]
