
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
  end
  
  def whatihavetodo
    @tasks = Application.instance.tasks
    puts ""
    @tasks.each do |t|
      msg ="TASK: #{t[:name]}"
      puts("="*msg.size)
      puts msg
      puts ""
      instance_eval &t[:block]
      puts ""
    end  
  end
    
  def target(description="empty")
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
    v=varname.to_s
    v=":#{v}" if varname.class==Symbol
    
    return("get(#{v})")
  end
  
  def unique(key,value)
    puts "    ! Unique value for <#{key.to_s}>"
    puts ""
  end
  
end
