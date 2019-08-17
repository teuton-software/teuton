#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../../../lib/application'
require_relative '../../../lib/project/name_file_finder'
require_relative '../../../lib/project/readme/readme'

# MiniTest Readme Class
class ReadmeTest < Minitest::Test
  def setup
  end

  def test_dsl
    dsl = [ :expect, :goal, :goto, :log , :target, :unique ]

    pathtofile = 'tests/files/example-01.rb'
    options = {}
    app = Application.instance
    NameFileFinder.find_filenames_for(pathtofile)
    readme = Readme.new(app.script_path, app.config_path)
    dsl.each { |i| assert_equal true, readme.methods.include?(i) }
  end

  def test_example01
    pathtofile = 'tests/files/example-01.rb'

    app = Application.instance
    NameFileFinder.find_filenames_for(pathtofile)
    require_relative app.script_path
    readme = Readme.new(app.script_path, app.config_path)

    data = { logs: [], groups: [], play: [] }
    assert_equal data, readme.data
    readme.process_content
    assert_equal [], readme.data[:logs]
    assert_equal 1, readme.data[:groups].count
    assert_equal 'group name 1', readme.data[:groups][0][:name]
    assert_equal 4, readme.data[:groups][0][:actions].count
    assert_equal 0, readme.data[:play].count
  end
end
