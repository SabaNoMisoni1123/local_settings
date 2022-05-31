mkdir $LOCAL_BIN
cd $LOCAL_BIN

curl -fsSL https://deno.land/x/install/install.sh | sh
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo chmod +x ./nvim.appimage

git clone git@github.com:SK-eee-ku/nvim_setting.git $XDG_CONFIG_HOME/nvim
./nvim.appimage --headless +so $XDG_CONFIG_HOME/nvim/init.vim +qa

sudo apt -y install xclip
