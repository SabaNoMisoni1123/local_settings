sudo apt -y install autoconf automake curl

git clone https://github.com/universal-ctags/ctags.git $LOCAL_BIN/ctags
cd $LOCAL_BIN/ctags
./autogen.sh
./configure --prefix=/usr/local # defaults to /usr/local
make -j
sudo make install # may require extra privileges depending on where to install

sudo snap install --classic code
cp $LOCAL_SETTINGS/vscode_setting/*.json ~/.config/Code/User/

cp -r $LOCAL_SETTINGS/.fonts ~/
sudo fc-cache -fv
