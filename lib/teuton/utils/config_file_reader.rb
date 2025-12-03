require "json"
require "yaml"

##
# Read config file content. Available file formats: YAML or JSON
module ConfigFileReader
  def self.read(filepath)
    return minimum_configuration_with_one_case unless File.exist?(filepath)

    return read_yaml(filepath) if [".yaml", ".yml"].include? File.extname(filepath)

    return read_json(filepath) if File.extname(filepath) == ".json"

    raise "[ERROR] ConfigFileReader.read: <#{filepath}>. Unkown extension!"
  end

  def self.convert_string_keys_to_symbol(input)
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

  def self.minimum_configuration_with_one_case
    data = {}
    data[:global] = {}
    data[:alias] = {}
    data[:cases] = [{tt_members: "anonymous"}]
    data
  end

  def self.is_yaml_file?(filepath)
    extensions = [".yaml", ".YAML", ".yml", ".YML"]
    ext = File.extname(filepath)
    return true if File.file?(filepath) && extensions.include?(ext)

    false
  end

  def self.is_json_file?(filepath)
    extensions = [".json", ".JSON"]
    ext = File.extname(filepath)
    return true if File.file?(filepath) && extensions.include?(ext)

    false
  end

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
    data
  end

  def self.read_json(filepath)
    data = JSON.parse(File.read(filepath), symbolize_names: true)
    data = convert_string_keys_to_symbol(data)
    data[:global] = data[:global] || {}
    data[:alias] = data[:alias] || {}
    data[:cases] = data[:cases] || []
    read_included_files!(filepath, data)
    data
  end

  def self.read_included_files!(filepath, data)
    return if data[:global][:tt_include].nil?

    include_dir = data[:global][:tt_include]
    basedir = if include_dir == File.absolute_path(include_dir)
      include_dir
    else
      File.join(File.dirname(filepath), data[:global][:tt_include])
    end
    filepaths = Dir.glob(File.join(basedir, "**/*"))
    filepaths.each { |filepath|
      if File.directory?(filepath)
        next
      elsif is_yaml_file? filepath
        data[:cases] << read_included_yaml_file(filepath)
      elsif is_json_file? filepath
        data[:cases] << read_included_json_file(filepath)
      elsif File.file? filepath
        warn "[WARN] Ignore config file <#{filepath}>. No yaml or json extension!"
        next
      end
    }
  end

  def self.read_included_yaml_file(filepath)
    begin
      data = YAML.load(File.open(filepath))
    rescue => e
      warn "[ERROR] ConfigFileReader.read_included_yaml: #{e}"
      warn "[ERROR] Loading configuration file! <#{filename}>"
      exit 1
    end
    data[:tt_source_file] = relative_path(filepath)
    convert_string_keys_to_symbol(data)
  end

  def self.read_included_json_file(filepath)
    begin
      data = JSON.parse(File.read(filepath), symbolize_names: true)
    rescue => e
      warn "[ERROR] ConfigFileReader.read_included_json: #{e}"
      warn "[ERROR] Loading configuration file! <#{filename}>"
      exit 1
    end
    data[:tt_source_file] = relative_path(filepath)
    convert_string_keys_to_symbol(data)
  end

  def self.relative_path(filepath)
    if filepath.start_with?(Dir.pwd)
      filepath[Dir.pwd.length + 1, filepath.length]
    else
      filepath
    end
  end
end
