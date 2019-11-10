echo '[ INFO ] TEUTON installation'
echo '[ INFO ] Debian package installation'
apt-get update
apt-get install -y ruby
apt-get install -y ssh
apt-get install -y make
apt-get install -y gcc
apt-get install -y ruby-dev

echo '[ INFO ] Gem installation'
gem install teuton
