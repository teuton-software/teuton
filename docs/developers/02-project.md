
# lib/project (module)

Function:

require: fileutils, rainbow, application

require_relative
* 'project/create.rb'
* 'project/find.rb'

Project functions invoked by CLI project tool
* test   -> (Test script)
            app.script_path (load script)
            project/laboratory (class)
* play   -> (Run script)
            case_manager/dsl (load: group, play)
            app.script_path (load script)
* create -> (Create skeleton)
            copyfile, create_dir, create_dirs, create
* find   -> (Find files)
            find_filenames_for, verbose, verboseln
