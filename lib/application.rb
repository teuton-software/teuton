# encoding: utf-8

require 'singleton'

class Application
  include Singleton
    
  attr_reader :name, :version

  def initialize
    @name="sysadmin-game"
    @version="0.5"
  end

end
