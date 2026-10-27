# frozen_string_literal: true

require_relative "../case/action/manager"
require_relative "../case/dsl/macro"
require_relative "../case/result/result"
require_relative "../utils/project"
require_relative "../utils/logger"
require_relative "dsl/all"
require_relative "show"

class Checker
  include DSL # Include case/DSL/macro functions only
  include CheckDSL

  attr_reader :result

  def initialize(script_path, config_path)
    @action_manager = Case::ActionManager.new
    @path = {}
    @path[:script] = script_path
    @path[:dirname] = File.dirname(script_path)
    @path[:filename] = File.basename(script_path, ".rb")
    @path[:config] = config_path
    reset
  end

  def reset
    @result = Result.new
    @targetid = 0
    @stats = {
      groups: 0,
      targets: 0,
      events: 0,
      logs: 0,
      readmes: 0,
      uniques: 0,
      hosts: {},
      gets: {},
      sets: [],
      uploads: []
    }
    @target_begin = nil
  end

  def show(onlyconfig)
    if onlyconfig
      show_onlyconfig
    else
      show_default
    end
  end

  private

  def show_default
    Logger.verbose = true
    process_content
    show = ShowCheck.new(stats: @stats, path: @path)
    show.show_stats
    show.revise_config_content
  end

  def show_onlyconfig
    Logger.verbose = false
    process_content
    Logger.verbose = true
    show = ShowCheck.new(stats: @stats, path: @path)
    show.suggest_config_content
  end

  def process_content
    groups = Project.value[:groups]
    option = Project.value[:options]

    Logger.puts ""
    if Project.value[:uses].size.positive?
      table = Terminal::Table.new do |t|
        t.style = { border: :unicode }
        t.add_row ["USE: external libraries"]
      end
      Logger.puts table
      Project.value[:uses].each_with_index { Logger.puts "      #{_2 + 1}. #{_1}" }
      Logger.puts ""
    end
    groups.each do |t|
      @stats[:groups] += 1
      unless option[:panel]
        msg = "GROUP: #{t[:name]}"
        table = Terminal::Table.new do |t|
          t.style = { border: :unicode }
          t.add_row [msg]
        end
        Logger.puts table
      end
      instance_eval(&t[:block])
    end
    return unless @target_begin

    Logger.warn "Last 'target' requires 'expect'\n"
  end
end
