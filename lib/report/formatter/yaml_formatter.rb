
require_relative 'base_formatter'

class YAMLFormatter < BaseFormatter

  def initialize(pReport)
    super(pReport)
    @data = {}
  end

  def process
    build_data
    w @data.to_s # Write data into ouput file
    deinit
  end

  def build_data
    build_initial_data
    build_history_data
    build_final_data
    build_hof_data
  end

  def build_initial_data
    head = {}
    head[:title] = "INITIAL CONFIGURATIONS"
    @head.each { |key,value| head[key]=value.to_s }
    @data[:initial_config] = head
  end

  def build_history_data
    body = {}
    body[:title] = "HISTORY"
    body[:logs] = []
    body[:targets] = []

    @lines.each do |i|
      line = ''
      if i.class.to_s=='Hash'
        lValue=0.0
        if i[:check]
          lValue=i[:weight]
        end

        target = {}
        target[:target_id]   = "%02d"%i[:id]
        target[:score]       = lValue.to_s
        target[:weight]      = i[:weight].to_s
        target[:description] = i[:description].to_s
        target[:command]     = i[:command].to_s
        target[:duration]    = i[:duration].to_s
        target[:alterations] = i[:alterations].to_s
        target[:expected]    = i[:expected].to_s
        target[:result]      = i[:result].to_s
        body[:targets] << target
      else
        body[:logs] << i.to_s
      end
    end
    @data[:history] = body
  end

  def build_final_data
    tail = {}
    tail[:title] = "FINAL VALUES"
    @tail.each { |key,value| tail[key] = value.to_s }
    @data[:final_values] = tail
  end

  def build_hof_data
    app = Application.instance
    return if app.options[:case_number]<3

    fame = {}
    fame[:title] = "HALL OF FAME"
    app.hall_of_fame.each { |line| fame[line[0]] = line[1] }
    @data[:hall_of_fame] = fame
  end

end
