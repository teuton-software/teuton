
require 'yaml'
require 'json'

# Functions that read dato from ConfigFile using formats YAML and JSON
module ConfigFileReader
  def self.read(filepath)
    if File.extname(filepath) == '.yaml'
      data = YAML.load(File.open(filepath))
      return data
    elsif File.extname(filepath) == '.json'
      data = JSON.parse(File.read(filepath), :symbolize_names => true)
      return data
    end
    raise "[ERROR] #{filepath} dosn't exist!"
  end
end
