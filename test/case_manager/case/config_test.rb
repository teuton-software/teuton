#!/usr/bin/ruby

require "minitest/autorun"
require_relative "../../../lib/teuton/case_manager/case/config"

class ConfigTest < Minitest::Test
  def setup
    @local = {
      tt_members: "Obiwan Kenobi",
      username: "obiwan",
      number: 42,
      from: "local",
      linux1_ip: "192.168.1.100",
      linux1_password: "secret"
    }
    @global = {
      dns: "8.8.4.4",
      ip_prefix: "172.19.",
      username: "sysadmingame",
      from: "global",
      linux1_username: "root"
    }
    @ialias = {
      user: :username,
      dns_ip: :dns,
      suse1: :linux1,
      ip: [:ip_prefix, :number, ".32"]
    }
    @config = Case::Config.new(local: @local, global: @global, alias: @ialias)
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
    assert_equal @local[:username], @config.local[:username]
    assert_equal false, @config.local[:tt_skip]
  end

  def test_local_get
    assert_equal @local[:tt_members], @config.get(:tt_members)
    assert_equal @local[:username], @config.get(:username)
    assert_equal "NODATA", @config.get(:tt_skip)
  end

  def test_running_get
    assert_equal "NODATA", @config.get(:say)
    @config.set(:say, "hello")
    assert_equal "hello", @config.get(:say)
  end

  def test_set_precedence
    assert_equal "local", @config.get(:from)
    @config.set(:from, "running")
    assert_equal "running", @config.get(:from)
    @config.unset(:from)
    assert_equal "local", @config.get(:from)
  end

  def test_unset
    assert_equal "local", @config.get(:from)
    @config.set(:from, "running")
    assert_equal "running", @config.get(:from)

    @config.unset(:from)
    assert_equal "local", @config.get(:from)
  end

  def test_ialias
    assert_equal @config.get(:username), @config.get(:user)
    assert_equal "obiwan", @config.get(:user)
    assert_equal @config.get(:dns), @config.get(:dns_ip)
    assert_equal "8.8.4.4", @config.get(:dns_ip)

    assert_equal @config.get(:linux1_ip), @config.get(:suse1_ip)
    assert_equal "192.168.1.100", @config.get(:suse1_ip)
    assert_equal @config.get(:linux1_username), @config.get(:suse1_username)
    assert_equal @config.get(:linux1_password), @config.get(:suse1_password)

    assert_equal "172.19.42.32", @config.get(:ip)
  end
end
