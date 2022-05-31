cd $LOCAL_BIN
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar xvf install-tl-unx.tar.gz
cd install-tl-*
sudo ./install-tl --repository http://mirror.ctan.org/systems/texlive/tlnet/
sudo /usr/local/texlive/[year]/bin/x86_64-linux/tlmgr path add
sudo apt -y install evince klatexfomura
cp $LOCAL_SETTINGS/.latexmkrc ~/
rm $LOCAL_BIN/install-tl-unx.tar.gz

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install --git https://github.com/latex-lsp/texlab.git --locked
