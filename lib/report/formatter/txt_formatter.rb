
require 'terminal-table'
require_relative 'base_formatter'

class TXTFormatter < BaseFormatter

  def initialize(report)
    super(report)
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
    w "INITIAL CONFIGURATIONS\n"
    my_screen_table = Terminal::Table.new do |st|
      @head.each { |key,value| st.add_row [ key.to_s, value.to_s] }
    end
    w my_screen_table.to_s+"\n\n"
  end

  def process_history
    tab="  "
    w "HISTORY\n"
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
				w tab+"\t\tDuration    : #{i[:duration].to_s} (#{i[:conn_type].to_s})\n"
        w tab+"\t\tAlterations : #{i[:alterations].to_s}\n"
        w tab+"\t\tExpected    : #{i[:expected].to_s} (#{i[:expected].class.to_s})\n"
        w tab+"\t\tResult      : #{i[:result].to_s} (#{i[:result].class.to_s})\n"
      else
        w(i.to_s + "\n\n")
      end
    end
  end

  def process_final
    w "FINAL VALUES\n"
    my_screen_table = Terminal::Table.new do |st|
      @tail.each do |key,value|
        st.add_row [ key.to_s, value.to_s]
      end
    end
    w my_screen_table.to_s+"\n"
  end

  def process_hof
    app=Application.instance
    return if app.options[:case_number]<3

    w "HALL OF FAME\n"
    app=Application.instance
    my_screen_table = Terminal::Table.new do |st|
      app.hall_of_fame.each do |line|
        st.add_row [ line[0], line[1]]
      end
    end
    w my_screen_table.to_s+"\n"

    deinit
  end

end
