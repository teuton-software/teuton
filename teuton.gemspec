Gem::Specification.new do |s|
  s.name        = 'teuton-server'
  s.version     = '0.0.0'
  s.executables << 'teuton-server'
  s.date        = '2019-11-08'
  s.summary     = "Teuton Server"
  s.description = "TeutonServer listen and respond to TeutonClients"
  s.authors     = ["David Vargas Ruiz"]
  s.email       = 'teuton.software@protonmail.com'
  s.files       = ['lib/server/files/server.yaml',
                   'lib/server/input_loader.rb',
                   'lib/server/service_manager.rb',
                   'lib/server/service.rb',
                   'lib/teuton-server.rb']
  s.homepage    = 'https://rubygems.org/gems/teuton-server'
  s.license     = 'GPL-3.0'
end
