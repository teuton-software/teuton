require 'fileutils'
require 'rainbow'

# Project#create
module Project
  def self.copyfile(target, dest)
    if File.exist? dest
      puts "* Exists file!      => #{Rainbow(dest).yellow}"
    else
      begin
        FileUtils.cp(target, dest)
        puts "* Create file       => #{Rainbow(dest).green}"
      rescue StandarError
        puts "* Create file ERROR => #{Rainbow(dest).red}"
      end
    end
  end

  def self.create_dir(dirpath)
    if Dir.exist? dirpath
      puts "* Exists dir!       => #{Rainbow(dirpath).yellow}"
    else
      begin
        FileUtils.mkdir_p(dirpath)
        puts "* Create dir        => #{Rainbow(dirpath).green}"
      rescue StandarError
        puts "* Create dir  ERROR => #{Rainbow(dirpath).red}"
      end
    end
  end

  def self.create_dirs(*args)
    args.each { |arg| create_dir arg }
  end

  def self.create(projectdir)
    projectname = File.basename(projectdir)

    puts "\n[INFO] Create project <#{Rainbow(projectname).bright}>"

    # Directory and assets Directory
    project_md_dir = File.join(projectdir, 'assets')
    create_dirs(projectdir, project_md_dir)

    source_basedir = File.join(File.dirname(__FILE__), '../..')

    # Ruby script, Configfile, gitignore
    items = [
      { source: 'lib/files/start.rb', target: 'start.rb' },
      { source: 'lib/files/config.yaml', target: 'config.yaml' },
      { source: 'lib/files/gitignore', target: '.gitignore' }
    ]
    items.each do |item|
      source = File.join(source_basedir, item[:source])
      target = File.join(projectdir, item[:target])
      copyfile(source, target)
    end

    source = File.join(source_basedir, 'lib/files/assets/README.md')
    target = File.join(project_md_dir, 'README.md')
    copyfile(source, target) # README.md
    puts ''
  end

end
