# use 'lib/gnulinux/user'
# use 'gnulinux/user'
use 'user'

group "learn-09-check" do
  macro 'user_exist', name: 'root'
  user_exist(name: 'fran')
  macro_user_exist(name: 'david')
end

play do
  show
  export
end
