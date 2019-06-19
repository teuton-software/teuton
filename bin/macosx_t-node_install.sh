#!/bin/bash
# MacOSX T-Node Installation
# version: 20190312

teutonPath=/usr/local/opt/teuton
teutonUrl=https://github.com/teuton-software/teuton.git
teutonLink=/usr/local/bin/teuton

function exists_binary() {
	which $1 > /dev/null
}

echo "[0/6.INFO] MacOSX T-NODE installation"

echo "[1/6.INFO] Checking if BREW is installed..."
exists_binary brew || ( echo "[ERROR] Brew must be installed to install T-Node" && exit 1 )

echo "[2/6.INFO] Installing PACKAGES..."
exists_binary git || brew install git
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

echo "[3/6.INFO] Rake gem installation"
gem install rake

echo "[4/6.INFO] Installing teuton..."
[ -d $teutonPath ] && rm -fr $teutonPath
git clone $teutonUrl $teutonPath -q

echo "[5/6.INFO] Configuring..."
cd $teutonPath
rake gems
rake
[ ! -L $teutonLink ] && echo "Creating symlink to $teutonPath/teuton in $teutonLink" && ln -s $teutonPath/teuton $teutonLink

echo "[6/6.INFO] Finish!"
teuton version
echo "[WARNING] Close current BASH and run a new one in order to have teuton working or run 'source ~/.bash_profile'."
