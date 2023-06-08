#!/usr/bin/env ruby

require "colorize"
require "yaml"

config = YAML.load(File.read("config.yaml"))
action = ARGV.first

config[:vms].each do |vm|
  cmd = "cd #{vm};vagrant #{action}"
  puts "==> [INFO] #{cmd}".light_yellow
  ok = system(cmd)
  puts "==> [ERROR] #{cmd}" unless ok 
end
