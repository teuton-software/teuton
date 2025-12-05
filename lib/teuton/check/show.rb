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
    Logger.info YAML.dump(output)
  end

  def revise_config_content
    unless File.exist?(@path[:config])
      Logger.warn "[WARN] Configfile not found"
      Logger.debug "       #{@path[:config]}"
      Logger.warn "[INFO] Recomended content:"
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
    my_screen_table = Terminal::Table.new do |st|
      st.add_row ["DSL Stats", "Count"]
      st.add_separator

      if Project.value[:uses].size.positive?
        st.add_row ["Uses", Project.value[:uses].size]
      end
      if Project.value[:macros].size.positive?
        st.add_row ["Macros", Project.value[:macros].size]
        Project.value[:macros].each_key { |value| st.add_row ["", value] }
      end
      st.add_row ["Groups", @stats[:groups]]
      st.add_row ["Targets", @stats[:targets]]
      runs = @stats[:hosts].values.inject(0) { |acc, item| acc + item }
      st.add_row ["Runs", runs]
      @stats[:hosts].each_pair { |k, v| st.add_row [" * #{k}", v] }
      if @stats[:uniques].positive?
        st.add_row ["Uniques", @stats[:uniques]]
      end
      if @stats[:logs].positive?
        st.add_row ["Logs", @stats[:logs]]
      end
      if @stats[:readmes].positive?
        st.add_row ["Readmes", @stats[:readmes]]
      end

      if @stats[:gets].size.positive?
        total = @stats[:gets].values.inject(0) { |acc, value| acc + value }
        st.add_row ["Gets", total]
        list = @stats[:gets].sort_by { |_k, v| v }
        list.reverse_each { |item| st.add_row [" * #{item[0]}", item[1].to_s] }
      end

      if @stats[:sets].size.positive?
        st.add_row ["Sets", @stats[:sets].size]
        @stats[:sets].each { |value| st.add_row ["", value] }
      end
      if @stats[:uploads].size.positive?
        st.add_row ["Uploads", @stats[:uploads].size]
        uploads = @stats[:uploads].select { _1 }
        uploads.each { |value| st.add_row ["", value] }
      end
    end
    Logger.info my_screen_table.to_s + "\n"
  end

  private

  def find_script_vars
    script_vars = [:tt_members]
    @stats[:hosts].each_key do |k|
      next if k == :localhost

      if k.instance_of? Symbol
        script_vars << (k.to_s + "_ip").to_sym
        script_vars << (k.to_s + "_username").to_sym
        script_vars << (k.to_s + "_password").to_sym
      else
        script_vars << k.to_s + "_ip"
        script_vars << k.to_s + "_username"
        script_vars << k.to_s + "_password"
      end
    end
    @stats[:gets].keys.each { |value| script_vars << value }
    script_vars
  end
end
