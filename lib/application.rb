# encoding: utf-8

require 'singleton'

class Application
  include Singleton
    
  attr_reader :name, :version
  attr_accessor :global, :tasks
  attr_reader :letter
  
  def initialize
    @name="sysadmin-game"
    @version="0.17.0"
    @global={}
    @tasks=[]
    @letter={ :good=>'.', :bad=>'F', :error=>'?' }
  end

end
