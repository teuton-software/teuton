# frozen_string_literal: true

require 'yaml'
require 'json'

# Functions that read data from ConfigFile using formats YAML and JSON
module ConfigFileReader
  def self.read(filepath)
    unless File.exist?(filepath)
      data = {}
      data[:cases] = [{ tt_members: 'anonymous' }]
      return data
    end
    if File.extname(filepath) == '.yaml'
      return read_yaml(filepath)
    elsif File.extname(filepath) == '.json'
      return read_json(filepath)
    end
    raise "[ERROR] ConfigFileReader: #{filepath}"
  end

  def self.read_yaml(filepath)
    begin
      data = YAML.load(File.open(filepath))
    rescue Exception => e
      puts "\n"
      puts '=' * 80
      puts "[ERROR] ConfigFileReader#read <#{filepath}>"
      puts '        I suggest to revise file format!'
      puts '        ' + e.message
      puts '=' * 80
      raise "[ERROR] ConfigFileReader <#{e}>"
    end
    data
  end

  def self.read_json(filepath)
    data = JSON.parse(File.read(filepath), symbolize_names: true)
    data
  end
end
