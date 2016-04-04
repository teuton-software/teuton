
require 'terminal-table'
require_relative 'application'
require_relative 'case/result'

def task(name, &block)
  Application.instance.tasks << { :name => name, :block => block }
end

def start(&block)
  #don't do nothing
end


class Laboratory
  attr_reader :result
  
  def initialize
    @result = Result.new
    @targetid=0
    @stats={ :tasks => 0, :targets => 0, :uniques => 0, :gets => 0}
    @gets={}
  end
  
  def whatihavetodo
    @tasks = Application.instance.tasks
    puts ""
    @tasks.each do |t|
      @stats[:tasks]+=1
      
      msg ="TASK: #{t[:name]}"
      my_screen_table = Terminal::Table.new { |st| st.add_row [ msg ] } 
      puts my_screen_table
      
      instance_eval &t[:block]
    end
    
    show_stats
  end
    
  def target(description="empty")
    @stats[:targets]+=1
    
    @targetid+=1
    i=@targetid
    puts "(%03d"%i+") target #{description}"
  end

  def goto(pHost=:localhost, pArgs={})
    h=pHost.to_s
    h=":#{h}" if pHost.class==Symbol

    puts "      goto   #{h} and #{pArgs.to_s}"
  end

  def expect(pCond, pArgs={})
    puts "      expect #{result.expected} (#{result.expected.class.to_s})"
    puts ""
  end
  
  def get(varname)
    @stats[:gets]+=1
    
    v=varname.to_s
    v=":#{v}" if varname.class==Symbol
    
    if @gets[v]
      @gets[v]+=1
    else
      @gets[v]=1
    end
    
    return "get(#{v})"
  end
  
  def unique(key,value)
    @stats[:uniques]+=1
    
    puts "    ! Unique value for <#{key.to_s}>"
    puts ""
  end
  
  def show_stats
    my_screen_table = Terminal::Table.new do |st|
        st.add_row [ "DSL Stats"  , "Count"] 
        st.add_separator
        st.add_row [ "Tasks"  , @stats[:tasks]] 
        st.add_row [ "Targets", @stats[:targets]] 
        st.add_row [ "Gets"   , @stats[:gets]] 
        st.add_row [ "Uniques", @stats[:uniques]] 
    end
    puts my_screen_table.to_s+"\n"
    
    return if @stats[:gets]==0
    
    my_screen_table = Terminal::Table.new do |st|
        st.add_row [ "Params Stats"  , "Count"] 
        st.add_separator
        @gets.each_pair do |key,value|
          st.add_row [ key  , value.to_s]
        end 
        st.add_separator
        st.add_row [ "TOTAL", @stats[:gets] ]
    end
    puts my_screen_table.to_s+"\n"
    
  end
  
end
