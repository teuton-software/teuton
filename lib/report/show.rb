
# Show methods for Report class.

class Report

  def show
    show_initial_configurations
    show_targets_history
    show_final_values
    show_hall_of_fame
  end

  private

  def show_initial_configurations
    puts 'INITIAL CONFIGURATIONS'
    my_screen_table = Terminal::Table.new do |st|
      @head.each { |key,value| st.add_row [ key.to_s, value.to_s] }
    end
    puts my_screen_table.to_s
  end

  def show_targets_history
    tab = '  '
    puts 'CASE RESULTS'
    @lines.each do |i|
      if i.class.to_s == 'Hash'
        value = 0.0
        value = i[:weight] if i[:check]
        print tab + "%03d" % i[:id] + ' (' + "%2d.2f" % value.to_f + '/'
        puts "%2d.2f" % i[:weight].to_f + ') ' + i[:description]
      else
        puts tab + '-  ' + i.to_s
      end
    end
  end

  def show_final_values
    puts 'FINAL VALUES'
    my_screen_table = Terminal::Table.new do |st|
      @tail.each do |key, value|
        st.add_row [key.to_s, value.to_s]
      end
    end
    puts my_screen_table.to_s
  end

  def show_hall_of_fame
    app = Application.instance
    return if app.hall_of_fame.count < 2
    puts 'HALL OF FAME'
    my_screen_table = Terminal::Table.new do |st|
      app.hall_of_fame.each do |line|
        st.add_row [line[0], line[1]]
      end
    end
    puts my_screen_table.to_s
  end
end
