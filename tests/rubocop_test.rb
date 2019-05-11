#!/usr/bin/env ruby

require 'minitest/autorun'

# MiniTest Rubocop
class RubocopTest < Minitest::Test
  def setup
    @files = []
    @files << 'lib/case_manager/case/dsl/deprecated.rb'
#    @files << 'lib/case_manager/case/dsl/expect.rb'
    @files << 'lib/case_manager/case/dsl/getset.rb'
#    @files << 'lib/case_manager/case/dsl/goto.rb'
    @files << 'lib/case_manager/case/dsl/log.rb'
    @files << 'lib/case_manager/case/dsl/main.rb'
#    @files << 'lib/case_manager/case/dsl/send.rb'
    @files << 'lib/case_manager/case/dsl/target.rb'
    @files << 'lib/case_manager/case/dsl/unique.rb'
  end

  def test_rubocop
    @files.each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      assert_equal true, lines.any?(/file inspected, no offenses detected/)
    end
  end
end
