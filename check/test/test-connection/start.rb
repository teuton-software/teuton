
=begin
This test just evaluate access to several diferent hosts, using SSH an telnet connections.
=end

require_relative 'connection'

start do
  show
  export :format => :colored_text
end
