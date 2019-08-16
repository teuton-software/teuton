#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../../../lib/application'
require_relative '../../../lib/project/readme/readme'

# MiniTest Readme Class
class ReadmeTest < Minitest::Test
  def setup
    @dsl = [ :expect, :goal, :goto, :log , :target, :unique ]
  end

  def test_initialize
    file = 'test/files/example-01.rb'
    options = {}
    data = { logs: [], groups: [], play: [] }
    readme = Readme.new(file, options)
    @dsl.each { |i| assert_equal true, readme.methods.include?(i) }
    assert_equal data, readme.data
    readme.process_content
    # TO TO !!!
#    puts "=> #{readme.data}"
  end

end
