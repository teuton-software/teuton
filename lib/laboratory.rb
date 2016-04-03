
require_relative 'tool'
require_relative 'case/result'

def task(name, &block)
  Tool.instance.define_task(name, &block)
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
    @tasks = Tool.instance.tasks
    @tasks.each do |t|
      msg ="TASK: #{t[:name]}"
      puts "" 
      puts("="*msg.size)
      puts msg
      puts ""
      instance_eval &t[:block]
    end  
  end
    
  def target(description="empty")
    @targetid+=1
    puts "(#{@targetid.to_s}) target \"#{description}\""
  end

  def goto(pHost=:localhost, pArgs={})
    puts "    goto #{pHost.to_s} and #{pArgs.to_s}"
  end

  def expect(pCond, pArgs={})
  end
  
  def get(varname)
    return("get(#{varname.to_sym})")
  end
  
  def unique(key,value)
    puts " *  Unique value for <#{key.to_s}>"
  end
  
end
