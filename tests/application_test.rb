#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../lib/application'

# MiniTest Application Class
class ApplicationTest < Minitest::Test
  def setup
    @app = Application.instance
  end

  def test_version
    assert_equal 'sysadmin-game', @app.name
    assert_equal '0.23.1', @app.version
  end

  def test_init_params
    assert_equal '.', @app.letter[:good]
    assert_equal 'F', @app.letter[:bad]
    assert_equal '?', @app.letter[:error]
    assert_equal ' ', @app.letter[:none]
    assert_equal 'var', @app.output_basedir
    assert_equal false, @app.debug
    assert_equal true, @app.verbose

    assert_equal true, @app.global == {}
    assert_equal [], @app.tasks
    assert_equal [], @app.hall_of_fame
  end

  def test_find_filenames_for
    app = Application.instance
    app.verbose = false
    # Simple mode, files exists
    app.find_filenames_for('tests/files/example-01.rb')
    assert_equal 'tests/files/example-01.rb', app.script_path
    assert_equal 'tests/files/example-01.yaml', app.config_path
    assert_equal 'example-01', app.test_name

    # Complex mode, dir empty
    app.find_filenames_for('tests/files/example-02')
    assert_equal 'tests/files/example-02/start.rb', app.script_path
    assert_equal 'tests/files/example-02/config.yaml', app.config_path
    assert_equal 'example-02', app.test_name

    # Complex mode, files exists
    app.find_filenames_for('tests/files/example-03')
    assert_equal 'tests/files/example-03/start.rb', app.script_path
    assert_equal 'tests/files/example-03/config.yaml', app.config_path
    assert_equal 'example-03', app.test_name

    # Simple mode, files exists with JSON
    app.find_filenames_for('tests/files/example-04.rb')
    assert_equal 'tests/files/example-04.rb', app.script_path
    assert_equal 'tests/files/example-04.json', app.config_path
    assert_equal 'example-04', app.test_name

    # Complex mode, files exists with JSON
    app.find_filenames_for('tests/files/example-05')
    assert_equal 'tests/files/example-05/start.rb', app.script_path
    assert_equal 'tests/files/example-05/config.json', app.config_path
    assert_equal 'example-05', app.test_name
    app.verbose = true
  end

end
