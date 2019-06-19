
require_relative 'base_formatter'

class ArrayFormatter < BaseFormatter

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
    @head.each { |key,value| head[key] = value }
    @data[:config] = head
  end

  def build_history_data
    body = {}
    groups = []
    group = {}

    body[:logs] = []
    group[:title] = 'Group name'
    group[:targets] = []

    @lines.each do |i|
      line = ''
      if i.class.to_s=='Hash'
        lValue=0.0
        if i[:check]
          lValue=i[:weight]
        end

        target = {}
        target[:target_id]   = "%02d"%i[:id]
        target[:score]       = lValue
        target[:weight]      = i[:weight]
        target[:description] = i[:description]
        target[:command]     = i[:command]
        target[:duration]    = i[:duration]
        target[:alterations] = i[:alterations]
        target[:expected]    = i[:expected]
        target[:result]      = i[:result]
        group[:targets] << target
      else
        body[:logs] << i.to_s
      end
    end

    groups << group
    body[:groups] = groups
    @data[:test] = body
  end

  def build_final_data
    tail = {}
    @tail.each { |key,value| tail[key] = value }
    @data[:results] = tail
  end

  def build_hof_data
    app = Application.instance
    return if app.options[:case_number]<3

    fame = {}
    app.hall_of_fame.each { |line| fame[line[0]] = line[1] }
    @data[:hall_of_fame] = fame
  end

end
