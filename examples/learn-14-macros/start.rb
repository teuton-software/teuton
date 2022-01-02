
use 'lib/user'

group "Learn about macros" do

  user_exist(name: 'fran')

  macro 'user_exist', name: 'root'

  macro_user_exist(name: 'david')

end

play do
  show
  export
end
