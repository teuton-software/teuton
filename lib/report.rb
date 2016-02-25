# encoding: utf-8

require 'terminal-table'
require_relative 'formatter/formatter_factory'

=begin
 This class maintain the results of every case, in a structured way.
=end

class Report
  attr_accessor :id, :outdir, :filename
  attr_accessor :head, :lines, :tail
  attr_reader :history
		
  def initialize(pId)
    @id=pId
    @outdir="var"
    @head={}
    @lines=[]
    @tail={}
    @history=""
  end

  def close
    lMax=0.0
    lGood=0.0
    lFail=0.0
    lFailCounter=0
    @lines.each do |i|
      if i.class.to_s=='Hash' then
        lMax += i[:weight] if i[:weight]>0
        if i[:check] then
          lGood+= i[:weight]
          @history+="."
        else
          lFail+= i[:weight]
          lFailCounter+=1
          @history+="?"
        end
      end
    end
    @tail[:max_weight]=lMax
    @tail[:good_weight]=lGood
    @tail[:fail_weight]=lFail
    @tail[:fail_counter]=lFailCounter
    @tail[:grade]=(lGood.to_f/lMax.to_f)*100.0
    if !@tail[:grade].finite? then
      @tail[:grade]=0.0
    end
    @tail[:grade]=0 if @tail[:unique_fault]>0
  end
									
  def show
    tab="  "
    puts 'INITIAL CONFIGURATIONS'
    my_screen_table = Terminal::Table.new do |st|
      @head.each { |key,value| st.add_row [ key.to_s, value.to_s] }
    end
    puts my_screen_table.to_s
    
    puts 'TARGETS HISTORY'
    @lines.each do |i|
      if i.class.to_s=='Hash' then
        value=0.0
        value=i[:weight] if i[:check]
        puts tab+"%03d"%i[:id]+" ("+"%2d.2f"%value.to_f+"/"+"%2d.2f"%i[:weight].to_f+") "+i[:description]
      else
        puts tab+"-  "+i.to_s
      end
    end
    puts 'FINAL VALUES'
    my_screen_table = Terminal::Table.new do |st|
      @tail.each do |key,value| 
        st.add_row [ key.to_s, value.to_s] 
      end
    end
    puts my_screen_table.to_s
  end		

  def export( format=:txt)
    filepath= File.join( @outdir, @filename+"."+format.to_s )
    @formatter = FormatterFactory::get(self, format, filepath)
    @formatter.process
  end

end
		

