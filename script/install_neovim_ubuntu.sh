mkdir $LOCAL_BIN
cd $LOCAL_BIN

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo chmod +x ./nvim.appimage

git clone git@github.com:SK-eee-ku/nvim_setting.git ./nvim
sudo apt install xclip
