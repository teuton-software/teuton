#!/usr/bin/env ruby
require "colorize"
require "yaml"

action = ARGV.first || "status"
exit 1 if action.nil?

dirpath = File.dirname(__FILE__)
filepath = File.join(dirpath, "config.yaml")
config = YAML.load(File.read(filepath))

start_time = Time.now
config[:vms].each do |vmname|
  vmdir = File.join(dirpath, vmname)
  cmd = "cd #{vmdir};vagrant #{action}"
  puts "==> [INFO] #{cmd}".light_yellow
  ok = system(cmd)
  puts "==> [ERROR] #{cmd}" unless ok
end
end_time = Time.now

config[:log][action] = end_time - start_time
File.write(filepath, YAML.dump(config), mode: "w")
