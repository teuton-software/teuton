#!/usr/bin/env ruby
require "colorize"
require "yaml"

dirpath = File.dirname(__FILE__)
filepath = File.join(dirpath, "config.yaml")
config = YAML.load(File.read(filepath))
action = ARGV.first || "status"

config[:vms].each do |vmname|
  vmdir = File.join(dirpath, vmname)
  cmd = "cd #{vmdir};vagrant #{action}"
  puts "==> [INFO] #{cmd}".light_yellow
  ok = system(cmd)
  puts "==> [ERROR] #{cmd}" unless ok
end
