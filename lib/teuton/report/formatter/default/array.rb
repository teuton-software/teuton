require_relative "../base_formatter"
require_relative "../../../utils/project"

class ArrayFormatter < BaseFormatter
  def initialize(report)
    super
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
    @lines.each do |line|
      unless line.instance_of? Hash
        @data[:logs] << line.to_s # Add log line
        next
      end

      # value = 0.0
      # value = line[:weight] if line[:check]
      if line[:groupname] != title
        # Add currentgroup
        groups << {title: title, targets: targets} unless title.nil?
        # Create new group
        title = line[:groupname]
        targets = []
      end
      target = line
      target[:target_id] = format("%<id>02d", id: line[:id])

      if options[:feedback] == false
        target[:command] = "*" * line[:command].size
        line[:output] = "" if line[:output].nil?
        target[:output] = "*" * line[:output].size
        target[:alterations] = "*" * line[:alterations].size
        target[:expected] = "*" * line[:expected].size
        target[:result] = "*" * line[:result].size
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
    @data[:hall_of_fame] = {}
    return if Project.value[:hall_of_fame].empty?

    fame = {}
    Project.value[:hall_of_fame].each { |line| fame[line[0]] = line[1] }
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
    Teuton::VERSION
  end
end
