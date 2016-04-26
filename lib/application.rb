# encoding: utf-8

require 'singleton'

class Application
  include Singleton
    
  attr_reader :name, :version
  attr_accessor :global, :tasks, :hall_of_fame
  attr_reader :letter
  
  def initialize
    @name="sysadmin-game"
    @version="0.17.2"
    @global={}
    @tasks=[]
    @letter={ :good=>'.', :bad=>'F', :error=>'?', :none=>' ' }
    @hall_of_fame=[]
  end

end
