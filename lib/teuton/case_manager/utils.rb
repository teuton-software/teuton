require "fileutils"
require_relative "../utils/project"

module Utils
  def ensure_dir(dirname)
    # TODO: Mover a la carpeta Utils
    # Create the directory if it dosn't exist.
    unless Dir.exist?(dirname)
      FileUtils.mkdir_p(dirname)
      return false
    end
    true
  end
end
