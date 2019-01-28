
module RakeFunction
  def self.challenges
    puts "[INFO] If your want sample TEUTON challenges, do this:"
    puts ""
    puts "       cd PAHT/TO/YOUR/DOCUMENTS"
    puts "       git clone https://github.com/dvarrui/teuton-challenges.git"
    puts ""
  end

  def self.update(packages)
    puts "[INFO] Pulling <teuton> repo..."
    system('git pull')
    install_gems packages
    system('ruby teuton version')
  end

  def self.chown_files
    puts "[INFO] Pulling <teuton> repo..."
    system('git pull')
    install_gems packages
    system('ruby teuton version')
  end
end
