# This is a script to setup all configs needed for a remote dev server
# It's intended to be used on a VirtualBox version of Ubuntu Server, and
# connected to via ssh-ing into it by a computer on the same network
#


# NOTE: CHECK IF ALL ALLOCATED MEMORY IS BEING USED CORRECTLY!!
# if not, following https://askubuntu.com/questions/1269493/ubuntu-server-20-04-1-lts-not-all-disk-space-was-allocated-during-installation
# enter:
# sudo vgdisplay
# sudo lvextend -l +100%FREE /dev/mapper/ubuntu--vg-ubuntu--lv
# sudo resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv



#
# VirtualBox Settings:
#
# Change adapter in network from LAN to Bridged
#
# Then set promiscuity to "All"
#
# 
#
# Install Ubuntu Server (v22.04 LTS)
# Select yes when it asks if you'd like to install openssh-server
# make the username u1, hostname dev-server
# 
# Run this script to download essentials
#
# Look at the output of "ifconfig -a" to see what ip address to connect to
# Then connect w/ another computer on the network vs ssh u1@192.168.0.X
#

echo "Beginning setup of dev server..."

# Install appropriate colors


# Setup rc files

# .vimrc

# ===================================
# ============= Config ==============
# ===================================

# Turn off firewall for ssh
# can check w/ sudo ufw status
sudo ufw allow ssh

# Initially thought that maybe in /etc/shh/ssh_config the line w/ Port 22 
# needed to be uncommented-- probably doesn't though

# ===================================
# ============= Install =============
# ===================================

# Things like git, python3 should be pre-installed

# Install this to use if-config
sudo apt-get install net-tools

# Install this to allow ssh via u1@dev-server.local (or other user@hostname.local)
sudo apt-get install avahi-daemon

# C/C++
sudo apt-get install gcc g++

# To download eigen, run
# git clone https://gitlab.com/libeigen/eigen.git

# To download stb for image io
# git clone https://github.com/nothings/stb

# To download opencv (header files in /usr/include/opencv4/opencv2)
sudo apt-get install libopencv-dev

# python, pip
sudo apt-get install python3-pip

# pipenv, and add command to PATH
pip3 install pipenv
echo "export PATH=$PATH:$HOME/.local/bin" >> ~/.bashrc
source $HOME/.bashrc




# Potentially useful links for setting up on VirtualBox:
# https://medium.com/@pierangelo1982/setting-ssh-connection-to-ubuntu-on-virtualbox-af243f737b8b
# https://linuxize.com/post/how-to-enable-ssh-on-ubuntu-18-04/
# https://dev.to/developertharun/easy-way-to-ssh-into-virtualbox-machine-any-os-just-x-steps-5d9i