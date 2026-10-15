require "rainbow"

class Logger
  @verbose = true

  class << self
    attr_writer :verbose
  end

  class << self
    attr_reader :verbose
  end

  def self.info(message)
    puts message if @verbose
  end

  def self.warn(message)
    text = Rainbow("Warn: #{message}").bright.yellow
    Kernel.warn text if @verbose
  end

  def self.error(message)
    text = Rainbow("Error: #{message}").bright.red
    Kernel.warn text if @verbose
  end

  def self.debug(message)
    text = Rainbow(message).white
    puts text if @verbose
  end
end
