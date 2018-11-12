
#require_relative 'opensuse'
require_relative 'samba-service'
require_relative 'samba-users'
require_relative 'samba-resources'
require_relative 'samba-configfile'

start do
  show
  export :format => :colored_text
end
