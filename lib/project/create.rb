
module Project

  def self.copyfile(target, dest)
    if File.exist? dest
      puts "* Exists file!        => #{Rainbow(dest).yellow}"
    else
      begin
        FileUtils.cp(target, dest)
        puts "* Creating file       => #{Rainbow(dest).green}"
      rescue Exception => e
        puts "* Creating file ERROR => #{Rainbow(dest).red}"
        puts e
      end
    end
  end

  def self.create_dir(dirpath)
    if Dir.exist? dirpath
      puts "* Exists dir!         => #{Rainbow(dirpath).yellow}"
    else
      begin
        Dir.mkdir(dirpath)
        puts "* Creating dir        => #{Rainbow(dirpath).green}"
      rescue Exception => e
        puts "* Creating dir  ERROR => #{Rainbow(dirpath).red}"
      end
    end
  end

  def self.create(pathtodir)
    projectdir  = pathtodir
    projectname = File.basename(pathtodir)

    puts "\n[INFO] Creating project <#{Rainbow(projectname).bright}>"

    # Directory
    create_dir projectdir

    source_basedir = File.join(File.dirname(__FILE__), '../..')
    source = File.join(source_basedir, 'lib/files/start.rb')
    target = File.join(projectdir, 'start.rb')
    copyfile(source, target) # Ruby script

    source = File.join(source_basedir, 'lib/files/config.yaml')
    target = File.join(projectdir, 'config.yaml')
    copyfile(source, target) # Configfile

    source = File.join(source_basedir, 'lib/files/gitignore')
    target = File.join(projectdir, '.gitignore')
    copyfile(source, target) # gitignore

    # md Directory
    project_md_dir = File.join(projectdir,'md')
    create_dir project_md_dir

    source_basedir = File.join(File.dirname(__FILE__), '../..')
    source = File.join(source_basedir, 'lib/files/md/README.md')
    target = File.join(project_md_dir, 'README.md')
    copyfile(source, target) # README.md

    puts ''
  end

end
