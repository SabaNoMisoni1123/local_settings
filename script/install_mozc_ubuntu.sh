sudo add-apt-repository ppa:ikuya-fruitsbasket/fcitx5
sudo apt upgrade
sudo apt install fcitx5-mozc
im-config -n fcitx5

echo "RUN sudo apt -y purge ibus"
