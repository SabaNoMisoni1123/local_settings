FROM python:3.9.10

USER root
ENV HOME=/root
ENV DEBIAN_FRONTEND=noninteractive

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
 && pip install --upgrade setuptools

COPY ./.*rc $HOME/
CMD ["/bin/zsh"]
