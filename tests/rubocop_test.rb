#!/usr/bin/env ruby

require 'minitest/autorun'

# MiniTest Rubocop
class RubocopTest < Minitest::Test
  def setup
    @files = {}

    @files[:case] = []
    @files[:case] << 'lib/teuton/case_manager/case/close.rb'
    @files[:case] << 'lib/teuton/case_manager/case/config.rb'
    @files[:case] << 'lib/teuton/case_manager/case/main.rb'
    @files[:case] << 'lib/teuton/case_manager/case/play.rb'

    @files[:case_manager] = []
    @files[:case_manager] << 'lib/teuton/case_manager/main.rb'
    @files[:case_manager] << 'lib/teuton/case_manager/show.rb'
    @files[:case_manager] << 'lib/teuton/case_manager/utils.rb'

    @files[:case_dsl] = []
    @files[:case_dsl] << 'lib/teuton/case_manager/case/dsl/deprecated.rb'
#    @files[:case_dsl] << 'lib/teuton/case_manager/case/dsl/expect.rb'
#    @files[:case_dsl] << 'lib/teuton/case_manager/case/dsl/getset.rb'
#    @files[:case_dsl] << 'lib/teuton/case_manager/case/dsl/goto.rb'
    @files[:case_dsl] << 'lib/teuton/case_manager/case/dsl/log.rb'
    @files[:case_dsl] << 'lib/teuton/case_manager/case/dsl/main.rb'
#    @files[:case_dsl] << 'lib/teuton/case_manager/case/dsl/send.rb'
    @files[:case_dsl] << 'lib/teuton/case_manager/case/dsl/target.rb'
    @files[:case_dsl] << 'lib/teuton/case_manager/case/dsl/unique.rb'

    @files[:cli] = []
    @files[:cli] << 'lib/teuton/cli/main.rb'
    @files[:cli] << 'lib/teuton/cli/play.rb'
    @files[:cli] << 'lib/teuton/cli/readme.rb'
    @files[:cli] << 'lib/teuton/cli/test.rb'
    @files[:cli] << 'lib/teuton/cli/version.rb'

    @files[:project] = []
    @files[:project] << 'lib/teuton/project/laboratory/laboratory.rb'
    @files[:project] << 'lib/teuton/project/readme/dsl.rb'
#    @files[:project] << 'lib/teuton/project/readme/readme.rb'
#    @files[:project] << 'lib/teuton/project/config_file_reader.rb'
#    @files[:project] << 'lib/teuton/project/name_file_finder.rb'
    @files[:project] << 'lib/teuton/project/project_creator.rb'
    @files[:project] << 'lib/teuton/project/project.rb'

    @files[:rake] = []
    @files[:rake] << 'Rakefile'
    @files[:rake] << 'tasks/build.rb'
    @files[:rake] << 'tasks/check.rb'
    @files[:rake] << 'tasks/install.rb'

    @files[:report] = []
#    @files4 << 'lib/teuton/report/formatter/array_formatter.rb'
    @files[:report] << 'lib/teuton/report/formatter/base_formatter.rb'
    @files[:report] << 'lib/teuton/report/formatter/json_formatter.rb'
    @files[:report] << 'lib/teuton/report/formatter/yaml_formatter.rb'

    @files[:result] = []
#    @files[:result] << 'lib/teuton/case_manager/case/result/result.rb'
    @files[:result] << 'lib/teuton/case_manager/case/result/ext_array.rb'
#    @files[:result] << 'lib/teuton/case_manager/case/result/ext_compare.rb'
    @files[:result] << 'lib/teuton/case_manager/case/result/ext_filter.rb'
  end

  def test_rubocop_case
    @files[:case].each do |file|
      output = `rubocop #{file}`
      puts "[DEBUG] #{file}" if $?.exitstatus > 0
      assert_equal 0, $?.exitstatus
    end
  end

  def test_rubocop_case_manager
    @files[:case_manager].each do |file|
      output = `rubocop #{file}`
      puts "[DEBUG] #{file}" if $?.exitstatus > 0
      assert_equal 0, $?.exitstatus
    end
  end

  def test_rubocop_case_dsl
    @files[:case_dsl].each do |file|
      output = `rubocop #{file}`
      puts "[DEBUG] #{file}" if $?.exitstatus > 0
      assert_equal 0, $?.exitstatus
    end
  end

  def test_rubocop_cli
    @files[:cli].each do |file|
      output = `rubocop #{file}`
      puts "[DEBUG] #{file}" if $?.exitstatus > 0
      assert_equal 0, $?.exitstatus
    end
  end

  def test_rubocop_project
    @files[:case_model].each do |file|
      output = `rubocop #{file}`
      puts "[DEBUG] #{file}" if $?.exitstatus > 0
      assert_equal 0, $?.exitstatus
    end
  end

  def test_rubocop
    @files[:rake].each do |file|
      output = `rubocop #{file}`
      puts "[DEBUG] #{file}" if $?.exitstatus > 0
      assert_equal 0, $?.exitstatus
    end
  end

  def test_rubocop_report
    @files[:report].each do |file|
      output = `rubocop #{file}`
      puts "[DEBUG] #{file}" if $?.exitstatus > 0
      assert_equal 0, $?.exitstatus
    end
  end

  def test_rubocop_result
    @files[:result].each do |file|
      output = `rubocop #{file}`
      puts "[DEBUG] #{file}" if $?.exitstatus > 0
      assert_equal 0, $?.exitstatus
    end
  end
end
