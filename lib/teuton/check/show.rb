require "terminal-table"
require "rainbow"

require_relative "../utils/project"
require_relative "../utils/configfile_reader"

class Laboratory
  def show
    @verbose = true
    process_content
    show_stats
    revise_config_content
  end

  def show_onlyconfig
    @verbose = false
    process_content
    @verbose = true
    recomended_panelconfig_content
  end

  private

  def verbose(text)
    print text if @verbose
  end

  def verboseln(text)
    puts text if @verbose
  end

  def process_content
    groups = Project.value[:groups]
    option = Project.value[:options]
    verboseln ""
    groups.each do |t|
      @stats[:groups] += 1
      unless option[:panel]
        msg = "GROUP: #{t[:name]}"
        my_screen_table = Terminal::Table.new { |st| st.add_row [msg] }
        verboseln my_screen_table
      end
      instance_eval(&t[:block])
    end
    if @target_begin
      puts Rainbow("WARN  Last 'target' requires 'expect'\n").bright.yellow
    end
  end

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
    @gets.each_key { |k| script_vars << k }
    script_vars
  end

  def recomended_config_content
    warn Rainbow("[WARN] Configfile not found").bright.yellow
    warn Rainbow("       #{@path[:config]}").white
    warn Rainbow("[INFO] Recomended content:").bright.yellow
    output = {global: nil, cases: []}
    output[:cases][0] = {}
    script_vars = find_script_vars
    script_vars.each { |i| output[:cases][0][i] = "VALUE" }
    verboseln Rainbow(YAML.dump(output)).white
  end

  def recomended_panelconfig_content
    output = {global: nil, cases: [{}]}
    script_vars = find_script_vars
    # script_vars.each { |i| output[:global][i] = "VALUE" }
    script_vars.each { |i| output[:cases][0][i] = "VALUE" }
    verboseln YAML.dump(output)
  end

  def revise_config_content
    unless File.exist?(@path[:config])
      recomended_config_content
      return
    end

    script_vars = find_script_vars
    config_vars = ConfigFileReader.read(@path[:config])
    config_vars[:global]&.each_key { |k| script_vars.delete(k) }
    config_vars[:alias]&.each_key { |k| script_vars.delete(k) }

    config_vars[:cases].each_with_index do |item, index|
      next if item[:tt_skip] == true

      script_vars.each do |value|
        next unless item[value].nil?

        next unless @sets[":" + value.to_s].nil?

        verbose Rainbow("  * Define ").red
        verbose Rainbow(value).red.bright
        verbose Rainbow(" value for Case[").red
        verbose Rainbow(index).red.bright
        verboseln Rainbow("] or set tt_skip = true").red
      end
    end
  end

  ##
  # Display stats on screen
  def show_stats
    my_screen_table = Terminal::Table.new do |st|
      st.add_row ["DSL Stats", "Count"]
      st.add_separator
      st.add_row ["Uses", Project.value[:uses].size]
      Project.value[:uses].each { |filepath| st.add_row ["", filepath] }
      st.add_row ["Macros", Project.value[:macros].size]
      Project.value[:macros].each_key { st.add_row ["", _1] }
      st.add_row [" ", " "]

      st.add_row ["Groups", @stats[:groups]]
      st.add_row ["Targets", @stats[:targets]]
      st.add_row ["Runs", @stats[:hosts].size]
      @stats[:hosts].each_pair { |k, v| st.add_row [" * #{k}", v] }
      st.add_row ["Uniques", @stats[:uniques]]
      st.add_row ["Logs", @stats[:uniques]]
      st.add_row [" ", " "]

      st.add_row ["Gets", @stats[:gets]]
      if @gets.count > 0
        list = @gets.sort_by { |_k, v| v }
        list.reverse_each { |item| st.add_row [" * #{item[0]}", item[1].to_s] }
      end

      st.add_row ["Sets", @stats[:sets].size]
      @stats[:sets].each { st.add_row ["", _1] }
    end
    verboseln my_screen_table.to_s + "\n"
  end
end
