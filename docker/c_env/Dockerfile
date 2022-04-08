FROM ubuntu:latest
USER root

ENV HOME /root
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
 && apt-get -y install locales tzdata \
 && localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 \
 && apt -y install \
    build-essential \
    zsh \
    vim \
    unzip \
    wget \
    curl \
    libssl-dev \
    clang \
    clang-tools

RUN wget https://github.com/Kitware/CMake/releases/download/v3.23.0/cmake-3.23.0.tar.gz \
 && tar zxvf cmake-3.23.0.tar.gz \
 && cd $HOME/cmake-3.23.0 \
 && ./bootstrap \
 && make -j12 \
 && make install -j8 \
 && cd $HOME \
 && rm cmake-3.23.0.tar.gz

ENV PATH $HOME/cmake-3.23.0/bin:$PATH

RUN apt-get -y purge tzdata unzip wget crul \
 && apt-get -y autoremove \
 && rm -rf /var/lib/apt/lists/*

WORKDIR $HOME
COPY ./.*rc $HOME/
CMD ["/bin/zsh"]
