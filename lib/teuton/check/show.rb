require "terminal-table"
require "rainbow"

require_relative "../utils/logger"
require_relative "../utils/project"
require_relative "../utils/config_file_reader"

class ShowCheck
  def initialize(stats:, path:)
    @stats = stats
    @path = path
  end

  def suggest_config_content
    output = {"global" => nil, "cases" => [{}]}
    script_vars = find_script_vars
    script_vars.each { |i| output["cases"][0][i.to_s] = "TOCHANGE" }
    Logger.puts YAML.dump(output)
  end

  def revise_config_content
    unless File.exist?(@path[:config])
      Logger.warn "Configfile not found"
      Logger.debug "- File: #{@path[:config]}"
      Logger.info "Recomended content:"
      suggest_config_content
      return
    end

    script_vars = find_script_vars
    config_vars = ConfigFileReader.call(@path[:config])
    config_vars[:global]&.each_key { |k| script_vars.delete(k) }
    config_vars[:alias]&.each_key { |k| script_vars.delete(k) }

    config_vars[:cases].each_with_index do |item, index|
      next if item[:tt_skip] == true

      script_vars.each do |value|
        next unless item[value].nil?

        setted = false
        @stats[:sets].each do |assign|
          setted = true if assign.include?(":#{value}=")
        end

        unless setted
          text = "  * Define '#{value}' value for Case[#{index}] or set tt_skip = true"
          Logger.error text
        end
      end
    end
  end

  def show_stats
    table = Terminal::Table.new do |t|
      t.style = {border: :unicode}
      t.add_row ["DSL Stats", "Count"]
      t.add_separator

      t.add_row ["Uses", Project.value[:uses].size] if Project.value[:uses].size.positive?
      if Project.value[:macros].size.positive?
        t.add_row ["Macros", Project.value[:macros].size]
        Project.value[:macros].each_key { |value| t.add_row ["", value] }
      end
      t.add_row ["Groups", @stats[:groups]]
      t.add_row ["Targets", @stats[:targets]]
      t.add_row ["Events", @stats[:events]]
      runs = @stats[:hosts].values.sum
      t.add_row ["Runs", runs]
      @stats[:hosts].each_pair { |k, v| t.add_row ["- #{k}", v] }
      t.add_row ["Uniques", @stats[:uniques]] if @stats[:uniques].positive?
      t.add_row ["Logs", @stats[:logs]] if @stats[:logs].positive?
      t.add_row ["Docs", @stats[:readmes]] if @stats[:readmes].positive?

      if @stats[:gets].size.positive?
        total = @stats[:gets].values.sum
        t.add_row ["Gets", total]
        list = @stats[:gets].sort_by { |_k, v| v }
        list.reverse_each { |item| t.add_row [" - #{item[0]}", item[1].to_s] }
      end

      if @stats[:sets].size.positive?
        t.add_row ["Sets", @stats[:sets].size]
        @stats[:sets].each { |value| t.add_row ["", value] }
      end
      if @stats[:uploads].size.positive?
        t.add_row ["Uploads", @stats[:uploads].size]
        uploads = @stats[:uploads].select { _1 }
        uploads.each { |value| t.add_row ["", value] }
      end
    end
    Logger.puts "\n#{table}\n"
  end

  private

  def find_script_vars
    script_vars = [:tt_members]
    @stats[:hosts].each_key do |k|
      next if k == :localhost

      if k.instance_of? Symbol
        script_vars << :"#{k}_ip"
        script_vars << :"#{k}_username"
        script_vars << :"#{k}_password"
      else
        script_vars << "#{k}_ip"
        script_vars << "#{k}_username"
        script_vars << "#{k}_password"
      end
    end
    @stats[:gets].each_key { |value| script_vars << value }
    script_vars
  end
end
