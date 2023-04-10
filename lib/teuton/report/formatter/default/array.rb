require_relative "../base_formatter"
require_relative "../../../utils/application"

class ArrayFormatter < BaseFormatter
  def initialize(report)
    super(report)
    @data = {}
  end

  def process(options = {})
    build_data(options)
    w @data.to_s # Write data into ouput file
    deinit
  end

  def build_data(options)
    build_initial_data
    build_history_data(options)
    build_final_data
    build_hof_data
  end

  private

  def build_initial_data
    head = {}
    @head.each { |key, value| head[key] = value }
    @data[:config] = head
  end

  def build_history_data(options)
    @data[:logs] = []
    groups = []
    title = nil
    targets = []
    @lines.each do |i|
      unless i.instance_of? Hash
        @data[:logs] << i.to_s # Add log line
        next
      end

      value = 0.0
      value = i[:weight] if i[:check]
      if i[:groupname] != title
        # Add currentgroup
        groups << {title: title, targets: targets} unless title.nil?
        # Create new group
        title = i[:groupname]
        targets = []
      end

      target = {}
      target[:target_id] = format("%<id>02d", id: i[:id])
      target[:check] = i[:check]
      target[:score] = value
      target[:weight] = i[:weight]
      target[:description] = i[:description]

      target[:conn_type] = i[:conn_type]
      target[:duration] = i[:duration]

      target[:command] = i[:command]
      target[:alterations] = i[:alterations]
      target[:expected] = i[:expected]
      target[:result] = i[:result]

      if options[:feedback] == false
        target[:command] = "*" * i[:command].size
        target[:alterations] = "*" * i[:alterations].size
        target[:expected] = "*" * i[:expected].size
        target[:result] = "*" * i[:result].size
      end

      targets << target
    end

    groups << {title: title, targets: targets} unless title.nil?
    @data[:groups] = groups
  end

  def build_final_data
    tail = {}
    @tail.each { |key, value| tail[key] = value }
    @data[:results] = tail
  end

  def build_hof_data
    app = Application.instance
    @data[:hall_of_fame] = {}
    return if app.options[:case_number] < 3

    fame = {}
    app.hall_of_fame.each { |line| fame[line[0]] = line[1] }
    @data[:hall_of_fame] = fame
  end

  def config
    @data[:config]
  end

  def results
    @data[:results]
  end

  def logs
    @data[:logs]
  end

  def groups
    @data[:groups]
  end

  def hall_of_fame
    @data[:hall_of_fame]
  end

  def version
    Application::VERSION
  end
end
