
module Project
  def self.create(pathtodir)
    projectdir  = pathtodir
    projectname = File.basename(pathtodir)

    puts "\n[INFO] Creating project <#{Rainbow(projectname).bright}>"

    # Directory
    if Dir.exist? projectdir
      puts "* Exists dir!        => #{Rainbow(projectdir).yellow}"
    else
      begin
        Dir.mkdir(projectdir)
        puts "* Creating dir        => #{Rainbow(projectdir).green}"
      rescue Exception => e
        puts "* Creating dir  ERROR => #{Rainbow(projectdir).red}"
      end
    end

    scriptfilepath = projectdir + '/start.rb'
    copyfile('lib/files/start.rb', scriptfilepath) # Ruby script

    configfilepath = projectdir + '/config.yaml'
    copyfile('lib/files/config.yaml', configfilepath) # Configfile

    gitignorefilepath = projectdir + '/.gitignore'
    copyfile('lib/files/gitignore', gitignorefilepath) # gitignore

    puts ''
  end
end
