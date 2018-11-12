
=begin
Spanish Exercise URL:
* https://github.com/dvarrui/libro-de-actividades/blob/master/actividades/add/devops/puppet-opensuse.md
=end

require_relative 'master-hostconf'
require_relative 'master-puppet'
require_relative 'client1-hostconf'
require_relative 'client1-puppet'
require_relative 'client1-actions'
require_relative 'client2-hostconf'
require_relative 'client2-actions'

start do
  show
  export :format => :colored_text
  send :copy_to => :master
end
