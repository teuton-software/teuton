# frozen_string_literal: true

require 'yaml'
require 'json/pure'

##
# Functions that read data from ConfigFile using YAML or JSON formats
module ConfigFileReader
  ##
  # Read config file
  # @param filepath (String) Path to config file
  # @return Hash with config data
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

  ##
  # Read YAML config file
  # @param filepath (String) Path to YAML config file
  # @return Hash with config data
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Security/YAMLLoad
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
    data = convert_string_keys_to_symbol(data)
    data[:global] = data[:global] || {}
    data[:alias] = data[:alias] || {}
    data[:cases] = data[:cases] || []
    read_included_files!(filepath, data)
    data
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Security/YAMLLoad

  ##
  # Read JSON config file
  # @param filepath (String) Path to JSON config file
  # @return Hash with config data
  def self.read_json(filepath)
    data = JSON.parse(File.read(filepath), symbolize_names: true)
    data = convert_string_keys_to_symbol(data)
    data[:global] = data[:global] || {}
    data[:alias] = data[:alias] || {}
    data[:cases] = data[:cases] || []
    read_included_files!(filepath, data)
    data
  end

  ##
  # Read all configuration files from "filepath" folder.
  # @param filepath (String) Folder with config files
  # @param data (Hash) Input configuration
  # rubocop:disable Security/YAMLLoad
  private_class_method def self.read_included_files!(filepath, data)
    return if data[:global][:tt_include].nil?

    include_dir = data[:global][:tt_include]
    if include_dir == File.absolute_path(include_dir)
      basedir = include_dir
    else
      basedir = File.join(File.dirname(filepath), data[:global][:tt_include])
    end
    files = Dir.glob(File.join(basedir, '**/*.yaml'))
    files.each { |file| data[:cases] << YAML.load(File.open(file)) }
  end
  # rubocop:enable Security/YAMLLoad

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  private_class_method def self.convert_string_keys_to_symbol(input)
    return input if input.class != Hash

    output = {}
    input.each_pair do |key, value|
      key2 = key
      key2 = key.to_sym if key.class
      value2 = value
      if value.class == Hash
        value2 = convert_string_keys_to_symbol(value)
      elsif value.class == Array
        value2 = []
        value.each { |i| value2 << convert_string_keys_to_symbol(i) }
      end
      output[key2] = value2
    end
    output
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize
end
