# encoding: utf-8

require 'singleton'

class Application
  include Singleton
    
  attr_reader   :name, :version, :letter, :output_basedir
  attr_accessor :global, :tasks, :hall_of_fame
  
  def initialize
    @name="sysadmin-game"
    @version="0.17.2"
    @letter={ :good=>'.', :bad=>'F', :error=>'?', :none=>' ' }
    @output_basedir="var"

    @global={}
    @tasks=[]
    @hall_of_fame=[]
  end

end
