require "json"
require "yaml"

##
# Read config file content. Available file formats: YAML or JSON
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
      data[:cases] = [{tt_members: "anonymous"}]
      return data
    end
    return read_yaml(filepath) if [".yaml", ".yml"].include? File.extname(filepath)

    return read_json(filepath) if File.extname(filepath) == ".json"

    raise "[ERROR] ConfigFileReader.read: <#{filepath}>. Unkown extension!"
  end

  ##
  # Read YAML config file
  # @param filepath (String) Path to YAML config file
  # @return Hash with config data
  def self.read_yaml(filepath)
    begin
      data = YAML.load(File.open(filepath))
    rescue => e
      warn "[ERROR] ConfigFileReader.read_yaml: #{e}"
      warn "[ERROR] Revise file content! <#{filepath}>"
      exit 1
    end
    data = convert_string_keys_to_symbol(data)
    data[:global] = data[:global] || {}
    data[:alias] = data[:alias] || {}
    data[:cases] = data[:cases] || []
    read_included_files!(filepath, data)
    convert_string_keys_to_symbol(data)
  end

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
    convert_string_keys_to_symbol(data)
  end

  ##
  # Read all configuration files from "filepath" folder.
  # @param filepath (String) Folder with config files
  # @param data (Hash) Input configuration
  private_class_method def self.read_included_files!(filepath, data)
    return if data[:global][:tt_include].nil?

    include_dir = data[:global][:tt_include]
    basedir = if include_dir == File.absolute_path(include_dir)
      include_dir
    else
      File.join(File.dirname(filepath), data[:global][:tt_include])
    end
    exts = {
      yaml: [".yaml", ".YAML", ".yml", ".YML"],
      json: [".json", ".JSON"]
    }
    filenames = Dir.glob(File.join(basedir, "**/*"))
    filenames.each { |filename|
      ext = File.extname(filename)
      if exts[:yaml].include? ext
        begin
          data[:cases] << YAML.load(File.open(filename))
        rescue
          warn "[ERROR] Loading configuration file! <#{filename}>"
        end
      elsif exts[:json].include? ext
        begin
          data[:cases] << JSON.parse(File.read(filename), symbolize_names: true)
        rescue
          warn "[ERROR] Loading configuration file! <#{filename}>"
        end
      elsif File.file? filename
        warn "[WARN] Ignored config file <#{filename}>. No yaml or json extension!"
      end
    }
  end

  private_class_method def self.convert_string_keys_to_symbol(input)
    return input if input.class != Hash

    output = {}
    input.each_pair do |key, value|
      key2 = key
      key2 = key.to_sym if key.class
      value2 = value
      if value.instance_of? Hash
        value2 = convert_string_keys_to_symbol(value)
      elsif value.instance_of? Array
        value2 = []
        value.each { |i| value2 << convert_string_keys_to_symbol(i) }
      end
      output[key2] = value2
    end
    output
  end
end
