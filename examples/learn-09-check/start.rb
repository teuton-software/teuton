# use 'lib/gnulinux/user'
# use 'gnulinux/user'
use 'user'

group "learn-09-check" do
  check 'user_exist', name: 'root'
  user_exist(name: 'fran')
  check_user_exist(name: 'david')
end

play do
  show
  export
end
