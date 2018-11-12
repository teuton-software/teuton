
=begin
Spanish URL:
* https://github.com/dvarrui/libro-de-actividades/blob/master/actividades/idp/dominios/pdc-winserver.md
=end

require_relative 'winserver-config'
require_relative 'winclients-config'
require_relative 'winserver-active-directory'

start do
  show
  #export :format => :colored_text
  export
end
