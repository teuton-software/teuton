#!/usr/bin/env ruby

require 'minitest/autorun'

# MiniTest Rubocop
class RubocopTest < Minitest::Test
  def setup
    @files1 = []
    @files1 << 'lib/case_manager/case/case_model/case_model.rb'
    @files1 << 'lib/case_manager/case/case_model/group_model.rb'
    @files1 << 'lib/case_manager/case/case_model/target_model.rb'

    @files2 = []
    @files2 << 'lib/case_manager/case/dsl/deprecated.rb'
#    @files << 'lib/case_manager/case/dsl/expect.rb'
    @files2 << 'lib/case_manager/case/dsl/getset.rb'
#    @files << 'lib/case_manager/case/dsl/goto.rb'
    @files2 << 'lib/case_manager/case/dsl/log.rb'
    @files2 << 'lib/case_manager/case/dsl/main.rb'
#    @files << 'lib/case_manager/case/dsl/send.rb'
    @files2 << 'lib/case_manager/case/dsl/target.rb'
    @files2 << 'lib/case_manager/case/dsl/unique.rb'

    @files3 = []
    @files3 << 'lib/project/laboratory.rb'
  end

  def test_rubocop_case_model
    @files1.each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      assert_equal true, lines.any?(/file inspected, no offenses detected/)
    end
  end

  def test_rubocop_case_dsl
    @files2.each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      assert_equal true, lines.any?(/file inspected, no offenses detected/)
    end
  end

  def test_rubocop_laboratoy
    @files3.each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      assert_equal true, lines.any?(/file inspected, no offenses detected/)
    end
  end
end
