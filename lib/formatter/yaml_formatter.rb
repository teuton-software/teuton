# encoding: utf-8

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
    @data[:head] = head
  end

  def build_history_data
    body = {}
    body[:title] = "HISTORY"
    body[:lines] = []

    @lines.each do |i|
      line = ""
      if i.class.to_s=='Hash' then
        lValue=0.0
        if i[:check]
          lValue=i[:weight]
        end

        line = {}
        line[:id]          = "%02d"%i[:id]+" ("+lValue.to_s+"/"+i[:weight].to_s+")"
        line[:description] = i[:description].to_s
        line[:command]     = i[:command].to_s
        line[:duration]    = i[:duration].to_s
        line[:alterations] = i[:alterations].to_s
        line[:expected]    = i[:expected].to_s
        line[:result]      = i[:result].to_s
      else
        line = i.to_s
      end
      body[:lines] << line
    end
    @data[:body] = bady
  end

  def build_tail_data
    tail = {}
    tail[:title] = "FINAL VALUES"
    @tail.each { |key,value| tail[key] = value.to_s }
    @data[:tail] = tail
  end

  def build_hof_data
    app = Application.instance
    return if app.options[:case_number]<3

    fame = {}
    fame[:title] = "HALL OF FAME"
    app.hall_of_fame.each { |line| fame[line[0]] = line[1] }
    @data[:fame] = fame
  end

end
