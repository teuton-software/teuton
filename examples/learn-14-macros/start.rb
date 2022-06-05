
use 'gnulinux/user'

group "Learn about modules" do

  user_exists(name: 'fran')
  macro 'user_exists', name: 'root'
  macro_user_exists(name: 'david')

end

play do
  show
  export
end
