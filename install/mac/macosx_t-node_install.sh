#!/bin/bash
# MacOSX T-Node Installation
# version: 20191205

function exists_binary() {
	which $1 > /dev/null
}

echo "[0/4.INFO] MacOSX T-NODE installation"

echo "[1/4.INFO] Checking if BREW is installed..."
exists_binary brew || ( echo "[ERROR] Brew must be installed to install T-Node" && exit 1 )

echo "[2/4.INFO] Installing PACKAGES..."
exists_binary rbenv || brew install rbenv
[ ! -f ~/.bash_profile ] && echo "Creating ~/.bash_profile file" && touch ~/.bash_profile
rbenvInit='eval "$(rbenv init -)"'
if cat ~/.bash_profile | grep -q "^${rbenvInit}$" 
then
	echo "rbenv already configured in ~/.bash_profile"
else
	echo "Adding rbenv config in ~/.bash_profile"
	echo ${rbenvInit} >> ~/.bash_profile
fi
rbenv init
rbenv install 2.6.2
[ ! -f ~/.ruby-version ] && echo "Creating ~/.ruby-version file" && echo "2.6.2" > ~/.ruby-version

echo "Switching to new ruby version" && rbenv global 2.6.2

source ~/.bash_profile

echo "[3/4.INFO] Installing teuton..."
gem install teuton

echo "[4/4.INFO] Finish!"
teuton version
echo "[WARNING] Close current BASH and run a new one in order to have teuton working or run 'source ~/.bash_profile'."
