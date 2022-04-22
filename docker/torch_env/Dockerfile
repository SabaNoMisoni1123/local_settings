FROM nvidia/cuda:11.3.0-cudnn8-runtime

USER root
ENV HOME=/root
ENV DEBIAN_FRONTEND=noninteractive

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

RUN pyenv install 3.8.13 \
 && pyenv global 3.8.13

RUN pip install --upgrade pip \
 && pip --no-cache-dir install \
        torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113

RUN apt-get purge -y git wget \
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /root/.config/matplotlib \
 && echo "backend : Agg" > /root/.config/matplotlib/matplotlibrc

COPY .vimrc /root/.vimrc
WORKDIR $HOME
