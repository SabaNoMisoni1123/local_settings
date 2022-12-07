# Ubuntu環境のセットアップ

## 内容

1. wsl2 の導入（Windows）
2. zsh
3. Neovim のインストール
4. texlive のインストール
5. 各種プログラミング言語の環境構築
	- c/cpp
	- Python
	- html/css (プログラミング言語ではない)
	- javasprict
	- julia
	- rust
6. VScode
7. 各種ソフトウェア等

## wsl2 の導入

基本的には検索した結果を使うだけ．ただし，BIOS の設定で CPU の仮想化を許可する必要があり若干困難．すべては公式サイトの情報で事足りた．

### x server

ここまでで十分ではあるが，クリップボード機能を有効化するために X server を導入する．まずは Windows 側で必要な処理．
1. VcXsrv をダウンロードする．
2. ググった結果を読んで初期設定と自動開始設定をする．
3. ファイアウォールの設定を変更して，VcXsrv に対しての項目をすべて許可する．(Windows ファイアーウォールによるアプリケーションの許可)

wsl2 側で必要な処理．
1. x server 用のパッケージのインストール．

```
sudo apt install x11-apps
```

2. .bash_profile に設定の追記

```
umask 022
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
```

x server はこれで導入できた．"xeyes"コマンドによって導入できているのかが確認できる．

## zsh
zsh をインストールする．
```
sudo apt install zsh
chsh -s /bin/zsh
```
.zshrc は次のようにする．
```
export LOCAL_SETTINGS=$HOME/local_settings
export LOCAL_BIN=[path to local bin ($HOME/appimages)]
source $LOCAL_SETTINGS/.zshrc
```

## Neovimのインストール

### Neovim本体

Neovim は appimage をダウンロードすることで入手する．設定ファイル群は，Git から clone する．SSH 鍵はググって何とかする．
適当な場所に保存すればいい．
```
mkdir $LOCAL_BIN
cd $LOCAL_BIN
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
ls
chmod +x nvim.appimage

cd ~
mkdir $XDG_CONFIG_HOME
cd $XDG_CONFIG_HOME
git clone git@github.com:SK-eee-ku/nvim.git ./nvim
```

Neovim の必要な設定を.bash_profile に書く．

```
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
alias v="$LOCAL_BIN/nvim.appimage"
alias nvim="$LOCAL_BIN/nvim.appimage"
```

### xclip

コピー&ペーストのために必要．
```
sudo apt install xclip
```

### jdk

英文校閲用プラグインに java+8 が必要．
```
sudo apt install default-jdk unzip
```

### textlint

npm を事前にインストールすることが必要．また，設定ファイルをホームディレクトリに配置する必要がある．
ルールの追加をした場合は，設定ファイル側にも反映させる．
```
sudo npm install -g textlint
sudo npm install -g \
    textlint-rule-preset-ja-technical-writing \
    textlint-rule-ja-space-around-link \
    textlint-rule-preset-ja-spacing \
    textlint-rule-spellcheck-tech-word
```

### 英単語辞書

nvim で英単語を補完するために必要．
**look**コマンドが使えることが前提．
辞書を以下のコマンドでインストールすればいい．
```
sudo apt install wamerican
```

### nextword
高性能な英語辞書?
次の英単語を予測するみたい．
go が必要．


```
go get -u github.com/high-moctane/nextword

# small
wget https://github.com/high-moctane/nextword-data/archive/refs/tags/small.tar.gz $LOCAL_BIN/
tar -zxvf $LOCAL_BIN/small.tar.gz

# large
wget https://github.com/high-moctane/nextword-data/archive/refs/tags/large.tar.gz $LOCAL_BIN/
tar -zxvf $LOCAL_BIN/large.tar.gz
```

## texlive の導入

### texliveの最新版のインストール

tlmgr を使って最新版の texlive を導入する．時間がかなりかかる．手順としてはミラーサイトからインストーラをダウンロードして実行するだけ．最後にパスを通すコマンドを実行すると texlive のインストールは完了する．注意すべきは，Ubuntu などでは初期で dvipdf などが入っていること．この場合は，コマンドによってパスを通しても，もとから入っている dvipdf などが使われてしまう．この場合はコンパイルがうまく実行できないので，zshrc などでパスを通す．

```
cd $LOCAL_BIN
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar xvf install-tl-unx.tar.gz
cd install-tl-[日付の番号]
sudo ./install-tl --repository http://mirror.ctan.org/systems/texlive/tlnet/
sudo /usr/local/texlive/[year]/bin/x86_64-linux/tlmgr path add
```
```
export PATH="/usr/local/texlive/[year]/bin/x86_64-linux:$PATH"
```


nvim でいい感じに tex をかけるようにするために evince をダウンロードする．
あと，便利ソフトを入れておく．

```
sudo apt install evince klatexfomura
```

さらに，.latexmkrc を次のようにする．

```
$latex = 'platex -syntex=1 %O %S';
$bibtex = 'pbibtex %O %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'mendex %O -o %D %S';
$max_repeat = 10;
$pdf_mode = 3;
$pdf_previewer="evince";
```

### latex用LSPの導入

#### texlab
rust が必要．
インストール後にパスを通す必要もあるはず．
```
cargo install --git https://github.com/latex-lsp/texlab.git --locked
```
#### ltex-ls
tarファイルをダウンロードして解凍．
[ltex-ls: releases](https://github.com/valentjn/ltex-ls/releases)
```
tar -xvf ./ltex-ls-[version]-linux-x64.tar.gz
```

### パッケージインストール
`/usr/local/texlive/texmf-local` の直下にファイルを配置して以下のコマンドを実行する．
```
sudo mktexlsr
```

### synctexの利用
synctexを利用するには，対応のPDF veiwerが必要．

#### Ubuntu
zathuraとxdotoolが必要．
```
sudo apt install zathru xdotool
```

#### Mac
skim.appが必要．また，skim側で設定をしなければならない．[参考サイト](https://htlsne.hatenablog.com/entry/2018/01/08/163552)

## 各種プログラミング言語の環境構築

### c/c++
clang，clangd は以下の方法でインストール．
```
sudo apt install clang
sudo apt install clangd-10
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-10 100
```

gcc/g++のバージョンが古い場合は以下の手順．これによりいくつかのバージョンをインストールできる．
```
sudo apt install gcc-7 gcc-8 gcc-9 g++-7 g++-8 g++-9
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 7
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 8
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 9
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 7
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 8
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 9
```

### Python

#### pyenv
Python は pyenv/pipenv を利用する．まずは pyenv で最新版の python をダウンロードし，pipenv をインストールする．


最初に Git が存在していることを確認し，パッケージの更新をする．さらに Python インストールに必要なパッケージをインストールしておく．

```
git --version
sudo apt update
sudo apt upgrade
sudo apt install build-essential libbz2-dev libdb-dev libreadline-dev libffi-dev libgdbm-dev liblzma-dev libncursesw5-dev libsqlite3-dev libssl-dev zlib1g-dev uuid-dev tk-dev
```

.bash_profile に次のコマンド書いておく．

```
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
```

Git を使い pyenv をダウンロードしたのちインストールできる Python のバージョンを確認．

```
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
pyenv install --list
```

所望のバージョン番号を使って次のように Python をインストール．その後，インストールした python をデフォルトに設定する．

```
python -m pip install --upgrade pip
pip install -r $LOCAL_SETTINGS/python/pip_standard.txt
```

#### Python-lsp-server

LSP 設定ファイルを所定のディレクトリにコピー

```
cp $LOCAL_SETTINGS/pycodestyle $XDG_CONFIG_HOME/
```

#### jupyter

jupyter を使えるようにする．まずは jupyter 関連のパッケージをインストール．拡張機能や補完機能もインストール．

```
pip install jupyter
pip install jupytext
pip install jupyter-contrib-nbextensions
pip install jupyter-nbextensions-configurator
git clone https://github.com/lambdalisue/jupyter-vim-binding $(jupyter --data-dir)/nbextensions/vim_binding
```

拡張機能の有効化

```
jupyter contrib nbextension install
jupyter nbextensions_configurator enable
jupyter nbextension enable vim_binding/vim_binding
jupyter nbextension enable code_prettify/autopep8
jupyter nbextension enable code_prettify/isort
jupyter nbextension enable toc2/main
#  jupyter nbextension enable hinterland/hinterland
```

jupytext の設定ファイルを作成．その後で設定ファイル(~/.jupyter/jupyter_notebook_config.py)に加筆．

```
jupyter notebook --generate-config
```

加筆した内容

```
c.NotebookApp.use_redirect_file = False
c.NotebookApp.contents_manager_class = "jupytext.TextFileContentsManager"
c.ContentsManager.default_jupytext_formats = "ipynb,py"
```

#### jupyter lab

```
pip install jupyterlab
jupyter labextension enable
pip install lckr-jupyterlab-variableinspector
jupyter labextension install @jupyterlab/toc
pip install jupyterlab_code_formatter
pip install jupyterlab_vim
```

いろいろな設定は lab ディレクトリを.jupyter 直下に保存

#### matplotlib

matplotlib で日本語を使えるようにしたい
~/.fonts に
[Takao font](https://launchpad.net/takao-fonts) から最新版の Takao font をダウンロードする

```
sudo fc-cache -fv
```

### javasprict

#### nodejs
node のバージョン管理方法はいろいろあるので，好きなほうを使う．
まずは nvm を使う場合は以下のコマンドを実行する．必要な設定は.zshrc にすでに書いている．
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm install --lts
```

以下は n を使うバージョン．
```
sudo apt install nodejs npm
sudo npm install n -g
sudo n stable
sudo apt purge nodejs npm
```

Mac では次のようになる
```
brew install n
sudo n stable
```

#### vuejs

nodejs がインストールされていることが前提．以下のコマンドを実行するだけ．LSP もあるので一緒にインストール．
```
npm install -g vue
npm install -g @vue/cli
npm install -g vls
```

#### deno
nodejs の進化系らしい．ddc.vim のために必要．

```
curl -fsSL https://deno.land/x/install/install.sh | sh
```

### html/css LSP

nodejs がインストールされていることが前提．css に関しては javasprict の LSP で対応できたはず．これを実現するために nodejs をダウンロードする．typescript-language-server に関しては，deno をインストールしている場合不要．

```
sudo npm install --global vscode-css-languageserver-bin
sudo npm install --global vscode-langservers-extracted
sudo npm install --global typescript-language-server typescript
```

### julia

julia をダウンロードしたうえで LSP も導入しておく．julia はダウンロードが少し面倒．

```
cd $LOCAL_BIN
wget https://julialang-s3.julialang.org/bin/linux/x64/1.5/julia-1.5.0-linux-x86_64.tar.gz
tar -zxvf julia-1.5.0-linux-x86_64.tar.gz
```

実行ファイルをダウンロードしたらパスを通す．.bash_profile に次のコマンドを加える．

```
export PATH="$LOCAL_BIN/julia-1.5.0/bin:$PATH"
```

julia は jupyter で実行が可能である．そのために julia の対話シェルを使いパッケージをインストールする．パッケージのインストールには julia の pkg モードを使う"]"によって pkg モードになる．

```
julia
> ]
> add IJulia
> C-c
```

LSP がうまくいってないみたいなので詳しくは今度がんばる．

### R language

1. GPG キーの登録
2. リポジトリの追加
3. インストール

```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'
sudo apt update
sudo apt install r-base
```

```
brew update && brew doctor && brew upgrade
brew tap homebrew/science
brew install r
```

### Go

ファイルをダウンロードして展開する方法．
```
cd $LOCAL_BIN
wget https://dl.google.com/go/go1.15.5.linux-amd64.tar.gz
sudo tar -C $LOCAL_BIN/ -xzf go1.15.5.linux-amd64.tar.gz
```
パスを通す．
```
export path="$path:path/to/go/bin"
```

goenv を利用する方法．.zsh に設定をしておいて，goenv リポジトリをインストール，実行する．

```
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
```

```
git clone https://github.com/syndbg/goenv.git ~/.goenv
goenv install [version numver]
goenv global [version numver]
```

LSP を導入
```
go get -u golang.org/x/tools/gopls@latest
go env -w GO111MODULE=auto
```

### rust

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

lsp は Ubuntu の場合はバイナリをインストール
```
curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > $LOCAL_BIN/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer
```
mac の場合 brew でインストール
```
brew install rust-analyzer
```

### Vimスクリプト
LSP は npm 経由でインストールできる．
```
sudo npm install -g vim-language-server
```

## VScode
Ubuntu ならば，snap を使ってインストール．
```
sudo snap install --classic code
```

### プラグイン
- vscode-neovim
- iceberg
- Python
- Pylance
- c/cpp
- clangd
- latex-workshop
- code spell checker
- jupyter

### setting

settings.json は所定の位置におく必要がある．

- MAC: ~/Library/Application\ Support/Code/User/
- Ubuntu: ~/.config/Code/User/settings.json


## 各種ソフトウェア

### cmake

cmake 公式サイトから最新版 cmake の圧縮ファイルの URL を取得．
[https://cmake.org/download/](https://cmake.org/download/)

```
wget [獲得したURL] /path/to/download
tar xvf /path/to/download
cd /path/to/download/cmake*/
./configure
make -j
sudo make install
cmake --version
```

### ctag

```
git clone https://github.com/universal-ctags/ctags.git $LOCAL_BIN/ctags
cd $LOCAL_BIN/ctags
sudo apt install autoconf # なんか必要らしい
./autogen.sh
./configure --prefix=/usr/local # defaults to /usr/local
make
sudo make install # may require extra privileges depending on where to install
```
mac だと brew で簡単インストール
```
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
```

### docker

#### wsl2 / mac

Windows で Docker Desktop をインストールする．この時，"Install required windows components for WSL 2"という選択項目にチェックをつける．
mac では，単に Docker Desktop をインストールするだけ．

#### Ubuntu

以下のコマンドでインストール．
この場合，使うときに sudo を使うか，ユーザが docker グループに入っているかのいずれかが必要．
```
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce
```

ユーザを docker グループに入れるには以下の手順．無理ならば，再起動．
```
sudo usermod -aG docker ${USER}
su - ${USER}
```

#### 使い方

インストールは適当にググる．Dokerfile もググる．
Dokerfile ができたら，以下の流れでコンテナが使える．
```
docker build -t [image name] -f [Dokerfile path]
docker create -it --name [container name]
docker start [container name]
docker attach [container name]
docker rm [container name]
```

### vim
Ubuntu
```
sudo apt install software-properties-common
sudo apt update
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim
```

### google drive
grive2 を使う．
```
sudo add-apt-repository ppa:nilarimogard/webupd8
sudo apt-get update
sudo apt-get install grive
```


ビルドする方法
```
sudo apt-get install libgcrypt20-dev libyajl-dev libboost-all-dev libcurl4-openssl-dev libexpat1-dev libcppunit-dev binutils-dev debhelper zlib1g-dev pkg-config
git clone https://github.com/vitalif/grive2.git
cd grive2
mkdir build
cd build
cmake ..
make -j
sudo make install
```

インストールできたら以下のコマンドを実行する．自動化に関してはうまく行ってないので，そのうち調査する．
```
cd /path/to/grive_dir
cp $LOCAL_SETTINGS/.griveignore ./

grive -a # 流れで認証を実行する

# 自動化
sudo apt install inotify-tools
systemctl --user enable grive-timer@$(systemd-escape google-drive).timer
systemctl --user start grive-timer@$(systemd-escape google-drive).timer
systemctl --user enable grive-changes@$(systemd-escape google-drive).service
systemctl --user start grive-changes@$(systemd-escape google-drive).service
```
停止は多分 stop と disable を使うと思われ．

### pandoc
Markdown のコンパイルなどで使う．apt を使えば簡単にインストールできるが最新版ではない．
```
sudo apt install pandoc
```
最新版をインストールするにはちょっと面倒な方法を使う必要がある．
```
cd $LOCAL_BIN
wget https://github.com/jgm/pandoc/releases/download/2.19/pandoc-2.19-1-amd64.deb
sudo dpkg -i pandoc-2.19-1-amd64.deb
```

### marp cli
Markdown をプレゼンテーションスライド形式でコンパイルする．
```
npm install -g @marp-team/marp-cli
```

### Nerd Fonts
ターミナルのフォントを**Nerd Fonts**に属するものにするとアイコンが反映されるのでかなり便利．[Nerd Fonts 日本語公式](https://github.com/ryanoasis/nerd-fonts/blob/master/readme_ja.md)を参考にする．


以下を使うといい．インストール方法は参考サイトなどを調べる．os側へのインストール．
- 白源Nerd

### efm-langserver
[efm-langserver: releases](https://github.com/mattn/efm-langserver/releases)
```
tar -xvf ./efm-langserver_v[version]_linux_amd64.tar.gz
```
