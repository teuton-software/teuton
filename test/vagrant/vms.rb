#!/usr/bin/env ruby
require "colorize"
require "yaml"

action = ARGV.first
if action.nil?
  puts "Usage: #{$0} [up|halt|destroy|status]"
  exit 1
end

dirpath = File.dirname(__FILE__)
filepath = File.join(dirpath, "config.yaml")
config = YAML.safe_load(
  File.read(filepath),
  permitted_classes: [Array, Hash, Symbol]
)

start_time = Time.now
config[:vms].each do |vmname|
  vmdir = File.join(dirpath, vmname)
  cmd = "cd #{vmdir};vagrant #{action}"
  puts "==> #{cmd}".light_yellow
  ok = system(cmd)
  puts "==> #{cmd}".light_red unless ok
end
end_time = Time.now

puts "==> Action (#{action}): #{end_time - start_time} secs".white
