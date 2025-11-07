#!/usr/bin/env ruby
# Requirements:
# - sudo systemctl start libvirtd
# - groups
# - sudo usermod -aG libvirt $USER
require "rainbow"
require "yaml"

action = ARGV.first
if action.nil?
  puts "Usage: #{$0} [up|halt|destroy|status] [filter]"
  exit 1
end

filter = ARGV[1] || :default
vagrantfiles = Dir.glob("test/vagrant/**/Vagrantfile")
vms = vagrantfiles.map { File.basename(File.dirname(_1)) }

# dirpath = File.dirname(__FILE__)
# filepath = File.join(dirpath, "config.yaml")
# config = YAML.safe_load(
#   File.read(filepath),
#  permitted_classes: [Array, Hash, Symbol]
# )

if action == "list"
  puts "VMS list:"
  vms.each { puts "* #{it}" }
  exit 0
end

start_time = Time.now
vms.each do |vmname|
  next if filter != :default && !vmname.include?(filter)

  vmdir = File.join("test/vagrant", vmname)
  cmd = "cd #{vmdir};vagrant #{action}"
  puts Rainbow("==> #{cmd}").bright.yellow
  ok = system(cmd)
  puts Rainbow("==> #{cmd}").bright.red unless ok
end
end_time = Time.now

puts Rainbow("==> Action (#{action}): #{end_time - start_time} secs").white
