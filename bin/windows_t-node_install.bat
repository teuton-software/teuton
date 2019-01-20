REM Windows T-NODE installation

git clone https://github.com/dvarrui/teuton.git
gem install rake

cd teuton
rake gems
rake get_challenges
rake
