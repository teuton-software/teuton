# encoding: utf-8

require 'rainbow'
require_relative 'base_formatter'

class TXTFormatter < BaseFormatter
	
  def initialize(pReport)
    super(pReport)
  end
		
  def process
    tab="  "
    w Rainbow("HEAD").bg(:blue)+"\n"
    @head.each { |key,value| w tab+key.to_s+": "+value.to_s+"\n" }

    w Rainbow("HISTORY").bg(:blue)+"\n"
    @lines.each do |i|
      if i.class.to_s=='Hash' then
        lValue=0.0
        lValue=i[:weight] if i[:check]
        w tab+Rainbow(i[:id].to_s).bg(:blue)+" ("+lValue.to_s+"/"+i[:weight].to_s+")\n"
        w tab+"\t\t"+Rainbow("Description").bright+" : #{i[:description].to_s}\n"
        w tab+"\t\t"+Rainbow("Command    ").bright+" : #{i[:command].to_s}\n"
      else
        w tab+"- "+i.to_s+"\n"
      end
    end

    w Rainbow("TAIL").bg(:blue)+"\n"
    @tail.each { |key,value| w tab+key.to_s+": "+value.to_s+"\n" }
    deinit
  end
  
end

