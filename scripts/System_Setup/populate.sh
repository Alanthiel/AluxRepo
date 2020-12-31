pacman -Syyu --noconform --needed
pacman -S alacritty fish qtile rofi code axel bmenu android-tools xsecurelock broot discord vlc gufw krita qbittorrent lutris seahorse gvim cronie dpkg base-devel mlocate gnome-keyring inxi neofetch lightdm-settings less lxappearance polkit-gnome ranger rsync speedtest-cli tree bpytop --noconfirm --needed
pamac install mailspring nerd-fonts-complete nerd-fonts-hermit picom-jonaburg-git clion pycharm-professional google-cloud-sdk
#mailspring nerd-fonts-complete nerd-fonts-hermit picom-jonaburg-git

#get into alux

su alux

#setup config git repo
cd ~alux
git clone "https://github.com/Alux-Alpha/AluxRepo"
cd AluxRepo
cd ~alux
mkdir .config
ln -s ~alux/AluxRepo/Dotfiles/* ~alux/.config/alacritty
cp -rf ~alux/workspace/repo/.git/* ~alux/AluxRepo

#setanaconda
conda init fish
conda create --name Encr
conda install --name Encr python==3.7 pycryptodome scrypt pyqt -y
conda create --name software_base
conda install --name software_base python==3.7 pyqt tk pycryptodome pandas numpy
conda create --name tensor_base
conda install --name tensor_base python==3.7 tensorflow-gpu keras-gpu pandas numpy seaborn pytinstaller scipy matplotlib

#lateral setups
mv ~alux/workspace/PycharmProjects ~alux/PycharmProjects
mv ~alux/workspaces/CLionProjects ~alux/ClionProjects
mv ~alux/workspace/'2FA recovery codes' ~alux/'2FA recovery codes'
mv ~alux/workspace/.aws ~alux/.aws
mv ~alux/workspace/.kaggle ~alux/.kaggle
mv ~alux/workspace/.git-credentials ~alux/.git-credentials

pip install kaggle --yes
