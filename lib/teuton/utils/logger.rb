require "rainbow"

class Logger
  @verbose = true

  def self.verbose=(value)
    @verbose = value
  end

  def self.verbose
    @verbose
  end

  def self.info(message)
    puts message if @verbose
  end

  def self.warn(message)
    text = Rainbow(message).bright.yellow
    info(text)
  end

  def self.error(message)
    text = Rainbow(message).bright.red
    info(text)
  end

  def self.debug(message)
    text = Rainbow(message).white
    info(text)
  end
end
