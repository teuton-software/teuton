
#TO-DO list

##Next Version

* Documentation
    * Revise Spanish docs
    * Mejorar la documentación en español
* DSL
    * `feedback or advise "Some usefull information"` provide this information when studends demand help.
    * `information`
* Gamification
    * When students demand help they could recibe some advises. 
    * Define a loop of executions of our activity. For example:
    every 5 minutes, run the activity, and repeat this 10 times.
    `start :times=>10, :duration=>5 do`      
* Task
    * 2 evaluation modes:
        1. Evaluate targets (current mode): `start :score=>:targets do ...`
        1. Evaluate task: `start :score=>:tasks do ...`

##In the future

* Documentation
    * Improve english documentation
    * Make videos showing how to use this tool
        * Download and installation
        * Examples 01 to 05...
* DSL
    * `export :format=>:html, :prefix => IAN`
    * `export :format=>:xml, :prefix => IAN`
    * `export :format=>:csv, :prefix => IAN`
    * `goto :hots1, :puppet => "Puppet instructions"`
    * `goto :hots1, :chef => "Chef instructions"`
    * `expect result.well_done?`
    * `information { author: "AUTHOR", version: "VERSION", url: "URL" }`
    * `result.test("...")
    * `send :email_to => :members_emails`
* Installation
    * Use Bundler to install gems instead of rake.
    * It will be usefull use sysadming-game as gem? And install it with `gem install sysadmin-game`.
* Code Quality
    * Implement unit tests using rspec and given-then-when.
    * Vagrant: test how to use vagrant machines as case hosts.
* Gamification
    * More ideas: bonus, lives, etc.
* Reports
    * Create reports with stat information: the worst target/task/case, 
    the best target/task/case, the slowest target/task/case, the
    the fastest target/task/case, etc.
    * Output format CSV, HTML, XML.
    * Related targets: group of targets that always have the same state
    in every case.    
