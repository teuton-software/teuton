# frozen_string_literal: true

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
      hosts: {},
      uniques: 0,
      logs: 0,
      gets: {},
      sets: [],
      uploads: []
    }
    @target_begin = nil
  end

  def show
    Logger.verbose = true
    process_content
    show_stats
    revise_config_content
  end

  def show_onlyconfig
    Logger.verbose = false
    process_content
    Logger.verbose = true
    recomended_panelconfig_content
  end

  private

  def process_content
    groups = Project.value[:groups]
    option = Project.value[:options]

    Logger.info ""
    if Project.value[:uses].size.positive?
      Logger.info Terminal::Table.new { |st| st.add_row ["USE: external libraries"] }
      Project.value[:uses].each_with_index { Logger.info "      #{_2 + 1}. #{_1}" }
    end
    groups.each do |t|
      @stats[:groups] += 1
      unless option[:panel]
        msg = "GROUP: #{t[:name]}"
        my_screen_table = Terminal::Table.new { |st| st.add_row [msg] }
        Logger.info my_screen_table
      end
      instance_eval(&t[:block])
    end
    if @target_begin
      Logger.warn "WARN  Last 'target' requires 'expect'\n"
    end
  end
end
