#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../lib/teuton/application'

class ApplicationTest < Minitest::Test
  def setup
    @app = Application.instance
    @app.reset
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

  def test_quiet?
    @app.verbose = false
    assert_equal false, @app.verbose
    assert_equal true, Application.instance.quiet?
    @app.verbose = true
    assert_equal true, @app.verbose
    assert_equal false, Application.instance.quiet?
    @app.options['quiet'] = true
    assert_equal true, Application.instance.quiet?
  end
end
