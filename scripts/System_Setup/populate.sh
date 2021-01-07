#Basic/Minimal System Setup

#install Basic Needed Packages
pacman -Syyu --noconform --needed
pacman -S alacritty fish qtile rofi code axel bmenu android-tools xsecurelock broot discord vlc gufw krita qbittorrent lutris seahorse gvim cronie dpkg base-devel mlocate gnome-keyring inxi neofetch lightdm-settings less lxappearance polkit-gnome ranger rsync speedtest-cli tree bpytop --noconfirm --needed
pamac install mailspring nerd-fonts-complete nerd-fonts-hermit picom-jonaburg-git clion pycharm-professional google-cloud-sdk intellij-idea-community-edition android-studio


#get into alux
su alux

#setup config git repo
cd ~alux
git clone "https://github.com/Alux-Alpha/AluxRepo"
cd AluxRepo
cd ~alux
mkdir .config
ln -s ~alux/AluxRepo/Dotfiles/.config/* ~alux/.config/
ln -s ~alux/AluxRepo/Dotfiles/home/* ~alux/
cp -rf ~alux/workspace/repo/.git/* ~alux/AluxRepo


#setanaconda
conda init fish

conda create --name Encr
conda install --name Encr python==3.7 -y
conda activate Encr
pip install pycryptodome scrypt pyqt
conda deactivate

conda create --name software_base
conda install --name software_base python==3.7 -y
conda activate software_base
pip install pyqt tk pycryptodome pandas numpy
conda deactivate

conda create --name tensor_base
conda install --name tensor_base python==3.7 -y
conda activate tensor_base
pip install tensorflow-gpu keras-gpu pandas numpy seaborn scipy matplotlib jupyter
conda deactivate


#lateral setups
mv ~alux/workspace/PycharmProjects ~alux/PycharmProjects
mv ~alux/workspaces/CLionProjects ~alux/ClionProjects
mv ~alux/workspaces/AndroidStudioProjects ~alux/AndroidStudioProjects
mv ~alux/workspaces/IdeaProjects ~alux/IdeaProjects
mv ~alux/workspace/'2FA recovery codes' ~alux/'2FA recovery codes'
mv ~alux/workspace/.aws ~alux/.aws
mv ~alux/workspace/.kaggle ~alux/.kaggle
mv ~alux/workspace/.git-credentials ~alux/.git-credentials

pip install kaggle
pip install aws
