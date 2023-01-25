require "terminal-table"
require "rainbow"

require_relative "../application"
require_relative "../utils/configfile_reader"

# Laboratory
# * show_dsl
# * show_stats
# * show_config
class Laboratory
  def show
    @verbose = true
    process_content
    show_stats
    revise_config_content
  end

  def show_panelconfig
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
    groups = Application.instance.groups
    option = Application.instance.options

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
  end

  def find_script_vars
    script_vars = [:tt_members]
    @hosts.each_key do |k|
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
    verbose Rainbow("[WARN] File ").yellow
    verbose Rainbow(@path[:config]).yellow.bright
    verboseln Rainbow(" not found!").yellow
    verboseln "[INFO] Recomended content:"
    output = {global: nil, cases: []}
    output[:cases][0] = {}
    script_vars = find_script_vars
    script_vars.each { |i| output[:cases][0][i] = "VALUE" }
    verboseln YAML.dump(output)
  end

  def recomended_panelconfig_content
    output = {global: {}, cases: nil}
    script_vars = find_script_vars
    script_vars.each { |i| output[:global][i] = "VALUE" }
    verboseln YAML.dump(output)
  end

  def revise_config_content
    my_screen_table = Terminal::Table.new do |st|
      st.add_row ["Revising CONFIG file"]
    end
    verboseln my_screen_table

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
    @stats[:hosts] = 0
    @hosts.each_pair { |_k, v| @stats[:hosts] += v }

    my_screen_table = Terminal::Table.new do |st|
      st.add_row ["DSL Stats", "Count"]
      st.add_separator
      st.add_row ["Groups", @stats[:groups]]
      st.add_row ["Targets", @stats[:targets]]
      st.add_row ["Runs", @stats[:hosts]]
      @hosts.each_pair { |k, v| st.add_row [" * #{k}", v] }
      st.add_row ["Uniques", @stats[:uniques]]
      st.add_row ["Logs", @stats[:uniques]]
      st.add_row [" ", " "]

      st.add_row ["Gets", @stats[:gets]]
      if @gets.count > 0
        list = @gets.sort_by { |_k, v| v }
        list.reverse_each { |item| st.add_row [" * #{item[0]}", item[1].to_s] }
      end

      st.add_row ["Sets", @stats[:sets]]
      if @sets.count > 0
        @sets.each_pair { |k, v| st.add_row [" * #{k}", v.to_s] }
      end
    end
    verboseln my_screen_table.to_s + "\n"
  end
end
