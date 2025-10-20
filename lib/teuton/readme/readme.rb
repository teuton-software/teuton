require_relative "../utils/logger"
require_relative "../utils/project"
require_relative "../utils/configfile_reader"
require_relative "../case/dsl/macro"
require_relative "../version"
require_relative "dsl/all"
require_relative "lang"
require_relative "result"

class Readme
  include DSL
  include ReadmeDSL

  attr_reader :result
  attr_reader :data

  def initialize(script_path, config_path)
    @path = {}
    @path[:script] = script_path
    @path[:dirname] = File.dirname(script_path)
    @path[:filename] = File.basename(script_path, ".rb")
    @path[:config] = config_path
    reset
  end

  def show
    process_content
    show_head
    show_content
    show_tail
  end

  private

  def reset
    @config = ConfigFileReader.read(Project.value[:config_path])
    @verbose = Project.value[:verbose]
    @result = ReadmeResult.new
    @data = {}
    @data[:macros] = []
    @data[:groups] = []
    @data[:play] = []
    reset_action
    @setted_params = {}
    @cases_params = []
    @global_params = {}
    @required_hosts = {}
  end

  def process_content
    Project.value[:groups].each do |group|
      @current = {name: group[:name], readme: [], actions: []}
      @data[:groups] << @current
      reset_action
      instance_eval(&group[:block])
    end
  end

  def reset_action
    @action = {readme: []}
  end

  def show_head
    puts "```"
    puts format(Lang.get(:date), Time.now)
    puts format(Lang.get(:version), Teuton::VERSION)
    puts "```"
    puts "\n"
    puts "# Test: #{Project.value[:test_name]}\n"

    i = 1
    unless @required_hosts.empty?
      puts Lang.get(:hosts)
      puts "\n"
      puts "| ID  | Host | Configuration |"
      puts "| --- | ---- | ------------- |"
      @required_hosts.each_pair do |k, v|
        c = []
        v.each_pair { |k2, v2| c << "#{k2}=#{v2}" }
        puts "| #{i} | #{k.upcase} | #{c.join(", ")} |"
        i += 1
      end
      puts "\n> NOTE: SSH Service installation is required on every host."
    end

    unless @cases_params.empty?
      @cases_params.sort!
      puts Lang.get(:params)
      @cases_params.uniq.each { |i| puts format("* %s", i) }
    end
  end

  def show_content
    @data[:groups].each do |group|
      next if group[:actions].empty?

      puts "\n## #{group[:name].capitalize}\n"
      group[:readme].each { |line| puts "#{line}\n" }
      previous_host = nil
      group[:actions].each_with_index do |item, index|
        if item[:host].nil? && index.positive?
          item[:host] = group[:actions][0][:host]
        end
        if previous_host.nil? || item[:host] != previous_host
          previous_host = item[:host] || "null"
          puts format(Lang.get(:goto), previous_host.upcase)
        end
        weight = "(x#{item[:weight]}) "
        last = item[:target].end_with?(".", ":") ? "" : "."
        puts "* #{weight}#{item[:target]}#{last}"
        item[:readme].each { |line| puts "    * #{line}\n" }
      end
    end
  end

  def show_tail
    return if (@global_params.size + @setted_params.size).zero?

    puts "\n---"
    puts "# ANEXO"
    puts "\n## Params"

    if @global_params.size.positive?
      puts Lang.get(:global_params)
      puts "\n"
      puts "| Param | Value |"
      puts "| ----- | ----- |"
      @global_params.each_pair { |k, v| puts "|#{k}|#{v}|" }
    end
    if @setted_params.size.positive?
      puts Lang.get(:created_params)
      puts "\n"
      puts "| Param |"
      puts "| ----- |"
      @setted_params.each_pair { |k, v| puts "|#{k}|" }
    end
  end
end
