# encoding: utf-8

require 'singleton'

class Application
  include Singleton
    
  attr_reader :name, :version
  attr_accessor :global, :tasks

  def initialize
    @name="sysadmin-game"
    @version="0.9.2"
    @global={}
    @tasks=[]
  end

end
