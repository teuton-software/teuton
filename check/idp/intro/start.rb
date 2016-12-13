
=begin
Spanish Exercise URL:
* https://github.com/dvarrui/libro-de-actividades/tree/master/actividades/idp/instalacion/live-cd
* https://github.com/dvarrui/libro-de-actividades/blob/master/actividades/global/configuracion-aula109.md
=end

require_relative 'windows'
require_relative 'opensuse'
#require_relative 'debian'

start do
  show
  export :format => :colored_text
  send :copy_to => :host2
#  send :copy_to => :host3
end
