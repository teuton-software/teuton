
module RakeFunction
  def self.challenges
    puts "[INFO] If your want download TEUTON challenges, do this:"
    puts ""
    puts "       cd PAHT/TO/YOUR/DOCUMENTS"
    puts "       teuton download_challenges"
    puts ""
  end

  def self.update(packages)
    puts "[INFO] Pulling <teuton> repo..."
    system('git pull')
    install_gems packages
    system('ruby teuton version')
  end

end
