#!/usr/bin/env ruby

require 'minitest/autorun'

# MiniTest Rubocop
class RubocopTest < Minitest::Test
  def setup
    @files = {}
    @files[:project] = []
    @files[:project] << 'lib/project/laboratory/laboratory.rb'
    @files[:project] << 'lib/project/readme/dsl.rb'
#    @files[:project] << 'lib/project/readme/readme.rb'
    @files[:project] << 'lib/project/create.rb'
    @files[:project] << 'lib/project/project.rb'
#    @files[:project] << 'lib/project/name_file_finder.rb'

    @files[:case] = []
    @files[:case] << 'lib/case_manager/case/result.rb'
    @files[:case] << 'lib/case_manager/case/result/ext_array.rb'
#    @files[:case] << 'lib/case_manager/case/result/ext_compare.rb'
    @files[:case] << 'lib/case_manager/case/result/ext_filter.rb'

    @files[:case_model] = []
    @files[:case_model] << 'lib/case_manager/case/case_model/case_model.rb'
    @files[:case_model] << 'lib/case_manager/case/case_model/group_model.rb'
    @files[:case_model] << 'lib/case_manager/case/case_model/target_model.rb'

    @files[:case_dsl] = []
    @files[:case_dsl] << 'lib/case_manager/case/dsl/deprecated.rb'
#    @files[:case_dsl] << 'lib/case_manager/case/dsl/expect.rb'
    @files[:case_dsl] << 'lib/case_manager/case/dsl/getset.rb'
#    @files[:case_dsl] << 'lib/case_manager/case/dsl/goto.rb'
    @files[:case_dsl] << 'lib/case_manager/case/dsl/log.rb'
    @files[:case_dsl] << 'lib/case_manager/case/dsl/main.rb'
#    @files[:case_dsl] << 'lib/case_manager/case/dsl/send.rb'
    @files[:case_dsl] << 'lib/case_manager/case/dsl/target.rb'
    @files[:case_dsl] << 'lib/case_manager/case/dsl/unique.rb'

    @files[:report] = []
#    @files4 << 'lib/report/formatter/array_formatter.rb'
    @files[:report] << 'lib/report/formatter/base_formatter.rb'
    @files[:report] << 'lib/report/formatter/json_formatter.rb'
    @files[:report] << 'lib/report/formatter/yaml_formatter.rb'
  end

  def test_rubocop_project
    @files[:case_model].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      assert_equal true, lines.any?(/file inspected, no offenses detected/)
    end
  end

  def test_rubocop_case
    @files[:case].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      assert_equal true, lines.any?(/file inspected, no offenses detected/)
    end
  end

  def test_rubocop_case_model
    @files[:case_model].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      assert_equal true, lines.any?(/file inspected, no offenses detected/)
    end
  end

  def test_rubocop_case_dsl
    @files[:case_dsl].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      assert_equal true, lines.any?(/file inspected, no offenses detected/)
    end
  end

  def test_rubocop_report
    @files[:report].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      assert_equal true, lines.any?(/file inspected, no offenses detected/)
    end
  end
end
