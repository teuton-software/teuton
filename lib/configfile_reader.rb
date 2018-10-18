# encoding: UTF-8

require 'yaml'
require 'json'

# Functions that read dato from ConfigFile using formats YAML and JSON
module ConfigFileReader
  def self.read(filepath)
    if File.extname(filepath) == '.yaml'
      begin
        data = YAML.load(File.open(filepath))
      rescue Exception => e
        puts "\n"
        puts '='*80
        puts "[ERROR] ConfigFileReader#read <#{filepath}>"
        puts '        I suggest to revise file format!'
        puts '='*80
        raise "[ERROR] ConfigFileReader <#{e}>"
      end
      return data
    elsif File.extname(filepath) == '.json'
      data = JSON.parse(File.read(filepath), :symbolize_names => true)
      return data
    end
      raise "[ERROR] #{filepath} dosn't exist!"
  end
end
