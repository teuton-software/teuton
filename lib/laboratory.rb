
require 'terminal-table'
require_relative 'application'
require_relative 'configfile_reader'
require_relative 'case/result'
#require 'pry-byebug'

def task(name, &block)
  Application.instance.tasks << { name: name, block: block }
end

def start(&block)
  # don't do nothing
end

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
    @stats = { tasks: 0, targets: 0, uniques: 0, gets: 0, logs: 0, sets: 0 }
    @gets = {}
    @sets = {}
    @hosts = {}
  end

  def whatihavetodo
    @tasks = Application.instance.tasks
    puts ''
    @tasks.each do |t|
      @stats[:tasks] += 1

      msg = "TASK: #{t[:name]}"
      my_screen_table = Terminal::Table.new { |st| st.add_row [msg] }
      puts my_screen_table

      instance_eval(&t[:block])
    end

    show_stats
    revise_config_content
  end

  def target(description = 'empty')
    @stats[:targets] += 1
    @targetid += 1
    i = @targetid
    puts "(%03d" % i + ") target #{description}"
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
    puts "      goto   #{host} and #{args}"
  end

  def run(command, args = {})
    args[:exec] = command
    goto( :localhost, args)
  end

  def expect(_cond, args = {})
    weight = 1.0
    weight = args[:weight].to_f if args[:weight]
    puts "      alter  #{result.alterations}" if !result.alterations.empty?
    puts "      expect #{result.expected} (#{result.expected.class})"
    puts "      weight #{weight}"
    puts ''
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

    puts "    ! Unique value for <#{key}>"
    puts ''
  end

  def log(text = '', type = :info)
    @stats[:logs] += 1
    puts "      log    [#{type}]: " + text.to_s
  end

  def set(key, value)
    @stats[:sets] += 1

    key = ':' + key.to_s if key.class == Symbol
    value = ':' + value.to_s if value.class == Symbol

    @sets[key] = value
    "set(#{key},#{value})"
  end

  def show_stats
    @stats[:hosts] = 0
    @hosts.each_pair { |_k, v| @stats[:hosts] += v }

    my_screen_table = Terminal::Table.new do |st|
      st.add_row ['DSL Stats', 'Count']
      st.add_separator
      st.add_row ['Tasks', @stats[:tasks]]
      st.add_row ['Targets', @stats[:targets]]
      st.add_row ['Goto', @stats[:hosts]]
      @hosts.each_pair { |k, v| st.add_row [" * #{k}", v] }
      st.add_row ['Uniques', @stats[:uniques]]
      st.add_row ['Logs', @stats[:uniques]]
      st.add_row [' ', ' ']

      st.add_row ['Gets', @stats[:gets]]
      if @gets.count > 0
        list = @gets.sort_by { |_k, v| v }
        list.reverse.each { |item| st.add_row [" * #{item[0]}", item[1].to_s] }
      end

      st.add_row ['Sets', @stats[:sets]]
      if @sets.count > 0
        @sets.each_pair { |k, v| st.add_row [" * #{k}", v.to_s] }
      end
    end
    puts my_screen_table.to_s + "\n"
  end

  private

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
    print Rainbow('[WARN] File ').yellow
    print Rainbow(@path[:config]).yellow.bright
    puts Rainbow(' not found!').yellow
    puts '[INFO] Recomended content:'
    output = { global: nil, cases: [] }
    output[:cases][0] = {}
    script_vars = find_script_vars
    script_vars.each { |i| output[:cases][0][i] = 'VALUE' }
    puts YAML.dump(output)
  end

  def revise_config_content
    puts '[INFO] Revise Config File content...'
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
#        binding.pry
        next unless item[value].nil?
        next unless @sets[':'+(value).to_s].nil?
#        next unless item[value].nil?
        print Rainbow('  * Define ').red
        print Rainbow(value).red.bright
        print Rainbow(' value for Case[').red
        print Rainbow(index).red.bright
        puts Rainbow('] or set tt_skip = true').red
      end
    end
  end
end
