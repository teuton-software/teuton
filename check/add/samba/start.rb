
require_relative 'opensuse'
require_relative 'samba-service'
require_relative 'samba-users'
require_relative 'samba-shares'

start do
  show
  export :format => :colored_text
end
