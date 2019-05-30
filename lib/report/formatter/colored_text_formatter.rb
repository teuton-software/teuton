
require 'rainbow'
require 'terminal-table'
require_relative 'base_formatter'

class ColoredTextFormatter < BaseFormatter

  def initialize(pReport)
    super(pReport)
  end

  def process
    process_initial
    process_history
    process_final
    process_hof
    deinit
  end

  private

  def process_initial
    w Rainbow("CONFIGURATIONS").bg(:blue)+"\n"
    my_screen_table = Terminal::Table.new do |st|
      @head.each { |key,value| st.add_row [ key.to_s, value.to_s] }
    end
    w my_screen_table.to_s+"\n\n"
  end

  def process_history
    tab="  "

    w Rainbow('TEST').bg(:blue)+"\n"
    @lines.each do |i|
      if i.class.to_s=='Hash'
        lValue=0.0
        color=:red
        if i[:check]
          lValue=i[:weight]
          color=:green
        end
        w tab + "%02d"%i[:id] + " ("+Rainbow(lValue.to_s+"/"+i[:weight].to_s).color(color)+")\n"
        w tab + "\t\t"+Rainbow("Description").bright + " : #{i[:description].to_s}\n"
        w tab + "\t\t"+Rainbow("Command    ").bright+" : #{i[:command].to_s}\n"
				w tab + "\t\t"+Rainbow("Duration   ").bright+" : #{i[:duration].to_s} (#{i[:conn_type].to_s})\n"
        w tab + "\t\t"+Rainbow("Alterations").bright+" : #{i[:alterations].to_s}\n"
        w tab + "\t\t"+Rainbow("Expected   ").bright+" : #{i[:expected].to_s} (#{i[:expected].class.to_s})\n"
        w tab + "\t\t#{Rainbow('Result     ').bright} : #{i[:result].to_s} (#{i[:result].class.to_s})\n"
      else
        w(i.to_s + "\n")
      end
    end
  end

  def process_final
    w Rainbow('RESULTS').bg(:blue) + "\n"
    my_screen_table = Terminal::Table.new do |st|
      @tail.each do |key,value|
        if key.to_s == 'grade'
          key = Rainbow(key.to_s).bright
          value = Rainbow(value.to_s).bright
        end
        if key.to_s == 'unique_fault' && value.to_i != 0
          key = Rainbow(key.to_s).bg(:red)
          value = Rainbow(value.to_s).bg(:red)
        end
        st.add_row [key.to_s, value.to_s]
      end
    end
    w my_screen_table.to_s + "\n\n"
  end

  def process_hof
    app = Application.instance
    return if app.options[:case_number] < 3

    w Rainbow('HALL OF FAME').bg(:blue) + "\n"
    my_screen_table = Terminal::Table.new do |st|
      app.hall_of_fame.each do |line|
        mycolor = :green
        mycolor = :red if line[0] < 50
        text1 = Rainbow(line[0]).color(mycolor)
        text2 = Rainbow(line[1]).color(mycolor)
        if line[0] == @tail[:grade]
          text1 = text1.bright
          text2 = text2.bright
        end
        st.add_row [text1, text2]
      end
    end
    w my_screen_table.to_s + "\n"
  end
end
