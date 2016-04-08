# encoding: utf-8

require 'terminal-table'
require_relative 'base_formatter'

class TXTFormatter < BaseFormatter
	
  def initialize(pReport)
    super(pReport)
  end
		
  def process
    tab="  "
    w "INITIAL CONFIGURATIONS\n"
    my_screen_table = Terminal::Table.new do |st|
      @head.each { |key,value| st.add_row [ key.to_s, value.to_s] }
    end
    w my_screen_table.to_s+"\n"

    w "TARGETS HISTORY\n"
    @lines.each do |i|
      if i.class.to_s=='Hash' then
        lValue=0.0
        color=:red
        if i[:check]
          lValue=i[:weight]
          color=:green 
        end
        w tab+"%02d"%i[:id]+" ("+lValue.to_s+"/"+i[:weight].to_s+")\n"       
        w tab+"\t\tDescription : #{i[:description].to_s}\n"
        w tab+"\t\tCommand     : #{i[:command].to_s}\n"
        w tab+"\t\tAlterations : #{i[:alterations].to_s}\n"
        w tab+"\t\tExpected    : #{i[:expected].to_s} (#{i[:expected].class.to_s})\n"
        w tab+"\t\tResult      : #{i[:result].to_s} (#{i[:result].class.to_s})\n"
      else
        w tab+"- "+i.to_s+"\n"
      end
    end

    w "FINAL VALUES\n"
    my_screen_table = Terminal::Table.new do |st|
      @tail.each do |key,value| 
        st.add_row [ key.to_s, value.to_s] 
      end
    end
    w my_screen_table.to_s+"\n"
    
    deinit
  end
  
end

