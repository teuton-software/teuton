REM Windows T-NODE installation
REM version: 20190121

git clone https://github.com/dvarrui/teuton.git
gem install rake

cd teuton
rake gems
rake get_challenges
rake
