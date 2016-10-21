
=begin
This are only tests
=end

require_relative 'opensuse'

start do
  show
  export :format => :colored_text
  send :copy_to => :host1
end
