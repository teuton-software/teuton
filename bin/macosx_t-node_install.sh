#!/bin/bash
# MacOSX T-Node Installation
# version: 20190312

teutonPath=/usr/local/opt/teuton
teutonUrl=https://github.com/dvarrui/teuton.git

function exists_binary() {
	which $1 > /dev/null
}

echo "[0/6.INFO] MacOSX T-NODE installation"

echo "[1/6.INFO] Installing BREW..."
exists_binary brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "[2/6.INFO] Installing PACKAGES..."
exists_binary git || brew install git
exists_binary chruby || brew install chruby 
exists_binary ruby-install || brew install ruby-install

[ ! -f ~/.ruby-version ] && echo "Creating ~/.ruby-version file" && echo "ruby" > ~/.ruby-version

[ ! -f ~/.bash_profile ] && echo "Creating ~/.bash_profile file" && touch ~/.bash_profile

chrubyPath=/usr/local/opt/chruby/share/chruby/
if cat ~/.bash_profile | grep -q "^source ${chrubyPath}/chruby.sh$" 
then
	echo "chruby.sh and auto.sh scripts already added to ~/.bash_profile"
else
	echo "Adding chruby.sh and auto.sh scripts to ~/.bash_profile"
	echo "source $chrubyPath/chruby.sh" >> ~/.bash_profile
	echo "source $chrubyPath/auto.sh" >> ~/.bash_profile
fi

echo "Running ~/.bash_profile script" && source ~/.bash_profile

$(chruby | grep -q ruby) || ( echo "Installing ruby..." && ruby-install ruby )

echo "Switching to new ruby version" && chruby ruby

echo "[3/6.INFO] Rake gem installation"
gem install rake

echo "[4/6.INFO] Installing teuton..."
git clone $teutonUrl $teutonPath -q

echo "[5/6.INFO] Configuring..."
cd $teutonPath
rake gems
rake
echo "Creating symlink to $teutonPath/teuton in /usr/local/bin/teuton" && ln -s $teutonPath/teuton /usr/local/bin/teuton

echo "[6/6.INFO] Finish!"
teuton version