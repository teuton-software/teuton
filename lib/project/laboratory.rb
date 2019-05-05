require 'terminal-table'
require 'rainbow'

require_relative '../application'
require_relative '../configfile_reader'
require_relative '../case/result'

def group(name, &block)
  Application.instance.groups << { name: name, block: block }
end
alias task group

def start(&block)
  # don't do nothing
end
alias play start

# Show objectives stats from RB script file
class Laboratory
  attr_reader :result

  def initialize(script_path, config_path)
    @path = {}
    @path[:script]   = script_path
    @path[:dirname]  = File.dirname(script_path)
    @path[:filename] = File.basename(script_path, '.rb')
    @path[:config]   = config_path

    @result = Result.new
    @targetid = 0
    @stats = { groups: 0, targets: 0, uniques: 0, gets: 0, logs: 0, sets: 0 }
    @gets = {}
    @sets = {}
    @hosts = {}
    @requests = []
    @verbose = Application.instance.verbose
  end

  def target(description = 'empty')
    @stats[:targets] += 1
    @targetid += 1
    i = @targetid
    verboseln "(%03d" % i + ") target #{description}"
  end
  alias :goal :target

  def request(text)
    @requests << text.to_s
  end

  def tempfile(_tempfile = nil)
    'tempfile'
  end

  def goto(host = :localhost, args = {})
    result.reset

    if @hosts[host]
      @hosts[host] += 1
    else
      @hosts[host] = 1
    end
    verboseln "      goto   #{host} and #{args}"
  end

  def run(command, args = {})
    args[:exec] = command
    goto(:localhost, args)
  end

  def expect(_cond, args = {})
    weight = 1.0
    weight = args[:weight].to_f if args[:weight]
    verboseln "      alter  #{result.alterations}" if !result.alterations.empty?
    verboseln "      expect #{result.expected} (#{result.expected.class})"
    verboseln "      weight #{weight}"
    verboseln ''
  end

  def get(varname)
    @stats[:gets] += 1

    if @gets[varname]
      @gets[varname] += 1
    else
      @gets[varname] = 1
    end

    "get(#{varname})"
  end

  def unique(key, _value)
    @stats[:uniques] += 1

    verboseln "    ! Unique value for <#{key}>"
    verboseln ''
  end

  def log(text = '', type = :info)
    @stats[:logs] += 1
    verboseln "      log    [#{type}]: " + text.to_s
  end

  def set(key, value)
    @stats[:sets] += 1

    key = ':' + key.to_s if key.class == Symbol
    value = ':' + value.to_s if value.class == Symbol

    @sets[key] = value
    "set(#{key},#{value})"
  end

  def show_dsl
    @verbose = true
    process_content
    show_stats
    show_config
  end

  def show_stats
    @stats[:hosts] = 0
    @hosts.each_pair { |_k, v| @stats[:hosts] += v }

    my_screen_table = Terminal::Table.new do |st|
      st.add_row ['DSL Stats', 'Count']
      st.add_separator
      st.add_row ['Groups', @stats[:groups]]
      st.add_row ['Targets', @stats[:targets]]
      st.add_row ['Goto', @stats[:hosts]]
      @hosts.each_pair { |k, v| st.add_row [" * #{k}", v] }
      st.add_row ['Uniques', @stats[:uniques]]
      st.add_row ['Logs', @stats[:uniques]]
      st.add_row [' ', ' ']

      st.add_row ['Gets', @stats[:gets]]
      if @gets.count > 0
        list = @gets.sort_by { |_k, v| v }
        list.reverse_each { |item| st.add_row [" * #{item[0]}", item[1].to_s] }
      end

      st.add_row ['Sets', @stats[:sets]]
      if @sets.count > 0
        @sets.each_pair { |k, v| st.add_row [" * #{k}", v.to_s] }
      end
    end
    verboseln my_screen_table.to_s + "\n"
  end

  def show_config
    @verbose = false
    process_content
    @verbose = true
    revise_config_content
  end

  def show_requests
    @verbose = false
    process_content
    @verbose = true
    my_screen_table = Terminal::Table.new do |st|
      st.add_row ['Lines', 'REQUEST description']
      st.add_separator
      @requests.each_with_index do |line, index|
        st.add_row ["%03d" % index, line]
      end
    end
    verboseln my_screen_table
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
    verboseln ''
    groups.each do |t|
      @stats[:groups] += 1

      msg = "GROUPS: #{t[:name]}"
      my_screen_table = Terminal::Table.new { |st| st.add_row [msg] }
      verboseln my_screen_table

      instance_eval(&t[:block])
    end
  end

  def find_script_vars
    script_vars = [:tt_members]
    @hosts.each_key do |k|
      next if k == :localhost

      if k.class == Symbol
        script_vars << (k.to_s + '_ip').to_sym
        script_vars << (k.to_s + '_username').to_sym
        script_vars << (k.to_s + '_password').to_sym
      else
        script_vars << k.to_s + '_ip'
        script_vars << k.to_s + '_username'
        script_vars << k.to_s + '_password'
      end
    end
    @gets.each_key { |k| script_vars << k }
    script_vars
  end

  def recomended_config_content
    verbose Rainbow('[WARN] File ').yellow
    verbose Rainbow(@path[:config]).yellow.bright
    verboseln Rainbow(' not found!').yellow
    verboseln '[INFO] Recomended content:'
    output = { global: nil, cases: [] }
    output[:cases][0] = {}
    script_vars = find_script_vars
    script_vars.each { |i| output[:cases][0][i] = 'VALUE' }
    verboseln YAML.dump(output)
  end

  def revise_config_content
    @verbose = true
    my_screen_table = Terminal::Table.new do |st|
      st.add_row ['Revising CONFIG file']
    end
    verboseln my_screen_table

    unless File.exist?(@path[:config])
      recomended_config_content
      return
    end

    script_vars = find_script_vars
    config_vars = ConfigFileReader.read(@path[:config])
    unless config_vars[:global].nil?
      config_vars[:global].each_key { |k| script_vars.delete(k) }
    end

    config_vars[:cases].each_with_index do |item, index|
      next if item[:tt_skip] == true

      script_vars.each do |value|
        next unless item[value].nil?

        next unless @sets[':' + value.to_s].nil?

        verbose Rainbow('  * Define ').red
        verbose Rainbow(value).red.bright
        verbose Rainbow(' value for Case[').red
        verbose Rainbow(index).red.bright
        verboseln Rainbow('] or set tt_skip = true').red
      end
    end
  end
end
