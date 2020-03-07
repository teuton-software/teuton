# frozen_string_literal: true

require 'fileutils'
require 'rainbow'

# Skeleton class
# * create
# * create_main_dir_and_files
# * create_assets_dir_and_files
# * create_dir
# * create_dirs
# * copyfile
module Skeleton
  def self.create(project_dir)
    project_name = File.basename(project_dir)
    puts "\n[INFO] Creating #{Rainbow(project_name).bright} project skeleton"
    source_basedir = File.join(File.dirname(__FILE__), '..')
    create_dir project_dir
    create_main_dir_and_files(project_dir, source_basedir)
  end

  def self.create_main_dir_and_files(project_dir, source_basedir)
    # Directory and files: Ruby script, Configfile, gitignore
    items = [
      { source: 'files/config.yaml', target: 'config.yaml' },
      { source: 'files/start.rb', target: 'start.rb' },
    # { source: 'files/README.md', target: 'README.md' },
      { source: 'files/gitignore', target: '.gitignore' }
    ]
    items.each do |item|
      source = File.join(source_basedir, item[:source])
      target = File.join(project_dir, item[:target])
      copyfile(source, target)
    end
  end

  def self.create_dir(dirpath)
    if Dir.exist? dirpath
      puts "* Exists dir!       => #{Rainbow(dirpath).yellow}"
    else
      begin
        FileUtils.mkdir_p(dirpath)
        puts "* Create dir        => #{Rainbow(dirpath).green}"
      rescue StandardError
        puts "* Create dir  ERROR => #{Rainbow(dirpath).red}"
      end
    end
  end

  def self.create_dirs(*args)
    args.each { |arg| create_dir arg }
  end

  def self.copyfile(target, dest)
    if File.exist? dest
      puts "* Exists file!      => #{Rainbow(dest).yellow}"
    else
      puts "* File not found!   => #{Rainbow(target).yellow}" unless File.exist? target
      begin
        FileUtils.cp(target, dest)
        puts "* Create file       => #{Rainbow(dest).green}"
      rescue StandardError
        puts "* Create file ERROR => #{Rainbow(dest).red}"
      end
    end
  end
end
