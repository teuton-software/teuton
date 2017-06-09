
require 'yaml'
require 'json'

# Functions that read dato from ConfigFile using formats YAML and JSON
module ConfigFileReader
  def self.read(configfile_pathname)
    data = YAML.load(File.open(configfile_pathname))
    data
  end
end
