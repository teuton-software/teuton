require_relative 'lib/application'

Gem::Specification.new do |s|
  s.name        = Application::NAME
  s.version     = Application::VERSION
  s.date        = '2019-11-09'
  s.summary     = "Teuton (Teuton Software)"
  s.description = "Intrastructure Test Software."

  s.license     = 'GPL-3.0'
  s.authors     = ['David Vargas Ruiz']
  s.email       = 'teuton.software@protonmail.com'
  s.homepage    = 'https://github.com/teuton-software/teuton'

  s.executables << 'teuton'
  #s.executables << 'teuton.bat'
  s.files       = Dir.glob(File.join('lib','**','*.rb'))

  s.add_runtime_dependency 'json', '~> 2.1'
  s.add_runtime_dependency 'net-sftp', '~> 2.1'
  s.add_runtime_dependency 'net-ssh', '~> 5.2'
  s.add_runtime_dependency 'net-telnet', '~> 0.2'
  s.add_runtime_dependency 'rainbow', '~> 3.0'
  s.add_runtime_dependency 'thor', '~> 0.20'
  s.add_runtime_dependency 'timeout', '~> 0.0'
  s.add_runtime_dependency 'terminal-table', '~> 1.8'

  s.add_development_dependency 'minitest', '~> 5.11'
  s.add_development_dependency 'rubocop', '~> 0.74'
end
