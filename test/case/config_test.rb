#!/usr/bin/ruby

require "minitest/autorun"
require_relative "../../lib/case/config"

class ConfigTest < Minitest::Test
  def setup
    @global = { :dns => '8.8.4.4', :username => 'sysadmingame', :from => 'global' }
    @local = { :tt_members => 'Obiwan Kenobi', :username => 'obiwan', :from => 'local' }
    @config = Case::Config.new( :local => @local, :global => @global)
  end

  def test_global
    assert_equal @global[:dns], @config.global[:dns]
    assert_equal @global[:username], @config.global[:username]
  end

  def test_global_get
    assert_equal @global[:dns], @config.get(:dns)
    refute_equal @global[:username], @config.get(:username)
  end

  def test_local
    assert_equal @local[:tt_members], @config.local[:tt_members]
    assert_equal @local[:username]  , @config.local[:username]
    assert_equal false              , @config.local[:tt_skip]
  end

  def test_local_get
    assert_equal @local[:tt_members], @config.get(:tt_members)
    assert_equal @local[:username]  , @config.get(:username)
    assert_equal false , @config.get(:tt_skip)
  end

  def test_running_get
    assert_equal nil, @config.get(:say)
    @config.set(:say, "hello")
    assert_equal "hello", @config.get(:say)
  end

  def test_running_precedence
    assert_equal 'local', @config.get(:from)
    @config.set(:from, "running")
    assert_equal "running", @config.get(:from)
  end

end
