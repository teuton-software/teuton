require "test/unit"
require_relative "../../lib/teuton/case/config"
require_relative "../../lib/teuton/case/host"

class HostTest < Test::Unit::TestCase
  def test_host_nil
    data = {}
    config = Case::Config.new(local: data, global: {}, alias: {})
    h = Case::Host.new(config).get(nil)
    assert_equal "localhost", h.ip
    assert_equal "local", h.protocol
    assert_equal 0, h.port
  end

  def test_host_localhost
    data = {host1_ip: "localhost"}
    config = Case::Config.new(local: data, global: {}, alias: {})
    h = Case::Host.new(config).get(:host1)
    assert_equal "localhost", h.ip
    assert_equal "local", h.protocol
    assert_equal 0, h.port
  end

  def test_host_127_0_0_1
    data = {host1_ip: "127.0.0.1"}
    config = Case::Config.new(local: data, global: {}, alias: {})
    h = Case::Host.new(config).get(:host1)
    assert_equal "127.0.0.1", h.ip
    assert_equal "local", h.protocol
    assert_equal 0, h.port
  end

  def test_host_127_0_0_1_ssh
    data = {host1_ip: "127.0.0.1", host1_protocol: "ssh"}
    config = Case::Config.new(local: data, global: {}, alias: {})
    h = Case::Host.new(config).get(:host1)
    assert_equal "127.0.0.1", h.ip
    assert_equal "ssh", h.protocol
    assert_equal 22, h.port
  end

  def test_host_192_182_1_201
    data = {
      host1_ip: "192.168.1.201",
      host1_username: "user",
      host1_password: "secret"
    }
    config = Case::Config.new(local: data, global: {}, alias: {})
    h = Case::Host.new(config).get(:host1)
    assert_equal "192.168.1.201", h.ip
    assert_equal "ssh", h.protocol
    assert_equal 22, h.port
    assert_equal "user", h.username
    assert_equal "secret", h.password
  end

  def test_host_192_182_1_202_telnet
    data = {
      host1_ip: "192.168.1.202",
      host1_username: "user",
      host1_password: "secret",
      host1_protocol: "telnet"
    }
    config = Case::Config.new(local: data, global: {}, alias: {})
    h = Case::Host.new(config).get(:host1)
    assert_equal "192.168.1.202", h.ip
    assert_equal "telnet", h.protocol
    assert_equal 23, h.port
    assert_equal "user", h.username
    assert_equal "secret", h.password
  end
end
