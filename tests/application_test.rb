#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../lib/application'

# MiniTest Application Class
class ApplicationTest < Minitest::Test
  def setup
    @app = Application.instance
    @app.reset
  end

  def test_version
    assert_equal 'teuton', @app.name
    assert_equal '2.0.0', @app.version
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
    assert_equal [], @app.groups
    assert_equal [], @app.hall_of_fame
  end
end
