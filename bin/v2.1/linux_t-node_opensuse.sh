echo '[ INFO ] TEUTON installation'
echo '[ INFO ] OpenSUSE package installation'
zypper refresh
zypper install --non-interactive ruby
zypper install --non-interactive openssh
zypper install --non-interactive make
zypper install --non-interactive gcc
zypper install --non-interactive ruby-devel

echo '[ INFO ] Gem installation'
gem install teuton
