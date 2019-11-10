echo '[ INFO ] TEUTON installation'
echo '[ INFO ] OpenSUSE package installation'
zypper refresh
zypper --non-interactive install ruby
zypper --non-interactive install openssh
zypper --non-interactive install make
zypper --non-interactive install gcc
zypper --non-interactive install ruby-devel

echo '[ INFO ] Gem installation'
gem install teuton
