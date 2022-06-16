# Ubuntu環境のセットアップ

## 内容

1. wsl2の導入（windows）
2. zsh
3. pythonのインストール
4. Neovimのインストール
5. texliveのインストール
6. 各種プログラミング言語の環境構築
	- c/cpp
	- python
	- html/css (プログラミング言語ではない)
	- javasprict
	- julia
	- rust
7. VScode
8. 各種ソフトウェア

## wsl2 の導入

基本的には検索した結果を使うだけ．ただし，BIOSの設定でCPUの仮想化を許可する必要があり若干困難．すべては公式サイトの情報で事足りた．

### x server

ここまでで十分ではあるが，クリップボード機能を有効化するためにX serverを導入する．まずはwindows側で必要な処理．
1. VcXsrvをダウンロードする．
2. ググった結果を読んで初期設定と自動開始設定をする．
3. ファイアーウォールの設定を変更して，VcXsrvに対しての項目をすべて許可する．(windowsファイアーウォールによるアプリケーションの許可)

wsl2側で必要な処理．
1. x server用のパッケージのインストール．

```
sudo apt install x11-apps
```

2. .bash_profileに設定の追記

```
umask 022
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
```

x serverはこれで導入できた．"xeyes"コマンドによって導入できているのかが確認できる．

## zsh
zshをインストールする．
```
sudo apt install zsh
chsh -s /bin/zsh
```
.zshrcは次のようにする．
```
export LOCAL_SETTINGS=$HOME/local_settings
export LOCAL_BIN=[path to local bin ($HOME/appimages)]
source $LOCAL_SETTINGS/.zshrc
```

## pythonのインストール

### pyenv
pythonはpyenv/pipenvを利用する．まずはpyenvで最新版のpythonをダウンロードし，pipenvをインストールする．


最初にgitが存在していることを確認し，パッケージの更新をする．さらにpythonインストールに必要なパッケージをインストールしておく．

```
git --version
sudo apt update
sudo apt upgrade
sudo apt install build-essential libbz2-dev libdb-dev libreadline-dev libffi-dev libgdbm-dev liblzma-dev libncursesw5-dev libsqlite3-dev libssl-dev zlib1g-dev uuid-dev tk-dev
```

.bash_profileに次のコマンド書いておく．

```
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
```

gitを使いpyenvをダウンロードしたのちインストールできるpythonのバージョンを確認．

```
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
pyenv install --list
```

所望のバージョン番号を使って次のようにpythonをインストール．その後，インストールしたpythonをデフォルトに設定する．

```
python -m pip install --upgrade pip
pip install -r $LOCAL_SETTINGS/python/pip_standard.txt
```

### python-lsp-server

LSP設定ファイルを所定のディレクトリにコピー

```
cp $LOCAL_SETTINGS/pycodestyle $XDG_CONFIG_HOME/
```

## Neovimのインストール

### Neovim本体

Neovimはappimageをダウンロードすることで入手する．設定ファイル群は，gitからcloneする．SSH鍵はググって何とかする．
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

Neovimの必要な設定を.bash_profileに書く．

```
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
alias v="$LOCAL_BIN/nvim.appimage"
alias nvim="$LOCAL_BIN/nvim.appimage"
```

### xclip

コピペのために必要．
```
sudo apt install xclip
```

### jdk

英文校閲用プラグインにjava+8が必要．
```
sudo apt install default-jdk unzip
```

### textlint

日本語校閲
npmを事前にインストールすることが必要．
```
sudo npm install -g textlint
sudo npm install -g textlint-rule-preset-ja-technical-writing textlint-rule-spellcheck-tech-word
```

### 英単語辞書

nvimで英単語を補完するために必要．
**look**コマンドが使えることが前提．
辞書を以下のコマンドでインストールすればいい．
```
sudo apt install wamerican
```

### nextword
高性能な英語辞書?
次の英単語を予測するみたい．
goが必要．


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

tlmgrを使って最新版のtexliveを導入する．時間がかなりかかる．手順としてはミラーサイトからインストーラをダウンロードして実行するだけ．最後にパスを通すコマンドを実行するとtexliveのインストールは完了する．注意すべきは，Ubuntuなどでは初期でdvipdfなどが入っていること．この場合は，コマンドによってパスを通しても，もとから入っているdvipdfなどが使われてしまう．この場合はコンパイルがうまく実行できないので，zshrcなどでパスを通す．

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


nvimでいい感じにtexをかけるようにするためにevinceをダウンロードする．
あと，便利ソフトを入れておく．

```
sudo apt install evince klatexfomura
```

さらに，.latexmkrcを次のようにする．

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
rustが必要．
インストール後にパスを通す必要もあるはず．
```
cargo install --git https://github.com/latex-lsp/texlab.git --locked
```

## 各種プログラミング言語の環境構築

### c/c++
LSPを使うだけなので簡単．clangと clangdをダウンロードすることで完了．
clangdは普通にはインストールできない．
clandのバージョンは探す．

```
sudo apt install clang clang-tools
sudo apt install clangd-10
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-10 100
```

### python

#### jupyter

jupyterを使えるようにする．まずはjupyter関連のパッケージをインストール．拡張機能や補完機能もインストール．

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

jupytextの設定ファイルを作成．その後で設定ファイル(~/.jupyter/jupyter_notebook_config.py)に加筆．

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

いろいろな設定はlabディレクトリを.jupyter直下に保存

#### matplotlib

matplotlibで日本語を使えるようにしたい
~/.fonts に
[Takao font](https://launchpad.net/takao-fonts) から最新版のTakao font をダウンロードする

```
sudo fc-cache -fv
```

### javasprict

#### nodejs
nodejsとVuejsのインストール方法．Ubuntuから．
```
sudo apt install nodejs npm
sudo npm install n -g
sudo n stable
sudo apt purge nodejs npm
```

Macでは次のようになる
```
brew install n
sudo n stable
```

#### vuejs

nodejsがインストールされていることが前提．以下のコマンドを実行するだけ．LSPもあるので一緒にインストール．
```
npm install -g vue
npm install -g @vue/cli
npm install -g vls
```

#### deno
nodejsの進化系らしい．ddc.vimのために必要．

```
curl -fsSL https://deno.land/x/install/install.sh | sh
```

### html/css LSP

nodejsがインストールされていることが前提．cssに関してはjavasprictのLSPで対応できたはず．これを実現するためにnodejsをダウンロードする．nを使うことで容易にバージョン管理する．typescript-language-serverに関しては，denoをインストールしている場合不要．

```
sudo npm install --global vscode-css-languageserver-bin
sudo npm install --global vscode-langservers-extracted
sudo npm install --global typescript-language-server
```

### julia

juliaをダウンロードしたうえでLSPも導入しておく．juliaはダウンロードが少し面倒．

```
cd $LOCAL_BIN
wget https://julialang-s3.julialang.org/bin/linux/x64/1.5/julia-1.5.0-linux-x86_64.tar.gz
tar -zxvf julia-1.5.0-linux-x86_64.tar.gz
```

実行ファイルをダウンロードしたらパスを通す．.bash_profileに次のコマンドを加える．

```
export PATH="$LOCAL_BIN/julia-1.5.0/bin:$PATH"
```

juliaはjupyterで実行が可能である．そのためにjuliaの対話シェルを使いパッケージをインストールする．パッケージのインストールにはjuliaのpkgモードを使う"]"によってpkgモードになる．

```
julia
> ]
> add IJulia
> C-c
```

LSPがうまくいってないみたいなので詳しくは今度がんばる．

### R language

1. GPG キーの登録
2. レポジトリの追加
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

goenvを利用する方法．.zsh に設定をしておいて，goenvレポジトリをインストール，実行する．

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

LSPを導入
```
go get -u golang.org/x/tools/gopls@latest
go env -w GO111MODULE=auto
```

### rust

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

lspはubuntuの場合はバイナリをインストール
```
curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > $LOCAL_BIN/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer
```
macの場合brewでインストール
```
brew install rust-analyzer
```

### vim script
LSPはnpm経由でインストールできる．
```
sudo npm install -g vim-language-server
```

## VScode
ubuntuならば，snapを使ってインストール．
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

settings.jsonは所定の位置におく必要がある．

- MAC: ~/Library/Application\ Support/Code/User/
- Ubuntu: ~/.config/Code/User/settings.json


## 各種ソフトウェア

### cmake

cmake公式サイトから最新版cmakeの圧縮ファイルのURLを取得．
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
macだとbrewで簡単インストール
```
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
```

### docker

#### wsl2 / mac

windowsでDocker Desktopをインストールする．この時，"Install required windows components for WSL 2"という選択項目にチェックをつける．
macでは，単にDocker Desktopをインストールするだけ．

#### ubuntu

以下のコマンドでインストール．
この場合，使うときにsudoを使うか，ユーザがdockerグループに入っているかのいずれかが必要．
```
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce
```

ユーザをdockerグループに入れるには以下の手順．無理ならば，再起動．
```
sudo usermod -aG docker ${USER}
su - ${USER}
```

#### 使い方

インストールは適当にググる．Dokerfileもググる．
Dokerfileができたら，以下の流れでコンテナが使える．
```
docker build -t [image name] -f [Dokerfile path]
docker create -it --name [container name]
docker start [container name]
docker attach [container name]
docker rm [container name]
```

### vim
ubuntu
sudo apt install software-properties-common
sudo apt update
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim
```
