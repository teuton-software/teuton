# frozen_string_literal: true

require 'yaml'
require 'json/pure'

# Functions that read data from ConfigFile using formats YAML and JSON
# * read
# * read_yaml
# * read_json
module ConfigFileReader
  def self.read(filepath)
    unless File.exist?(filepath)
      data = {}
      data[:global] = {}
      data[:alias] = {}
      data[:cases] = [{ tt_members: 'anonymous' }]
      return data
    end
    return read_yaml(filepath) if File.extname(filepath) == '.yaml'

    return read_json(filepath) if File.extname(filepath) == '.json'

    raise "[ERROR] ConfigFileReader: #{filepath}"
  end

  def self.read_yaml(filepath)
    begin
      data = YAML.load(File.open(filepath))
    rescue StandardError => e
      puts "\n" + ('=' * 80)
      puts "[ERROR] ConfigFileReader#read <#{filepath}>"
      puts '        I suggest to revise file format!'
      puts "        #{e.message}\n" + ('=' * 80)
      raise "[ERROR] ConfigFileReader <#{e}>"
    end
    data[:global] = data[:global] || {}
    data[:alias] = data[:alias] || {}
    data[:cases] = data[:cases] || []
    data
  end

  def self.read_json(filepath)
    data = JSON.parse(File.read(filepath), symbolize_names: true)
    data[:global] = data[:global] || {}
    data[:alias] = data[:alias] || {}
    data[:cases] = data[:cases] || []
    data
  end
end
