
=begin
Spanish Exercise URL:
* https://github.com/dvarrui/libro-de-actividades/blob/master/actividades/add/devops/puppet-opensuse.md
=end

require_relative 'master-hostconf'

#require_relative 'windows'
#require_relative 'windows-server'
#require_relative 'debian'

start do
  show
  export :format => :colored_text
  send :copy_to => :master
end
