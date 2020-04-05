require_relative 'lib/teuton/application'

Gem::Specification.new do |s|
  s.name        = Application::NAME
  s.version     = Application::VERSION
  s.date        = '2020-04-05'
  s.summary     = "Teuton (Teuton Software)"
  s.description = <<-EOF
  Intrastructure test, useful for:
  (1) Sysadmin teachers to evaluate students remote machines.
  (2) Sysadmin apprentices to evaluate their learning process as a game.
  (3) Professional sysadmin to monitor remote machines.

  Allow us:
  (a) Write test units for real or virtual machines using simple DSL.
  (b) Check compliance with requirements on remote machines.
  EOF

  s.extra_rdoc_files = [ 'README.md', 'LICENSE' ] +
                       Dir.glob(File.join('docs','**','*.md'))

  s.license     = 'GPL-3.0'
  s.authors     = ['David Vargas Ruiz']
  s.email       = 'teuton.software@protonmail.com'
#  s.homepage    = 'https://github.com/teuton-software/teuton'
  s.homepage    = 'https://github.com/teuton-software/teuton/tree/devel'

  s.executables << 'teuton'
#  s.executables << 'teuton.bat'
  s.files       = Dir.glob(File.join('lib','**','*.rb')) +
                  Dir.glob(File.join('lib','teuton','files','*'))
  s.required_ruby_version = '>= 2.5.0'

  s.add_runtime_dependency 'json_pure', '~> 2.2'
  s.add_runtime_dependency 'net-sftp', '~> 2.1'
  s.add_runtime_dependency 'net-ssh', '~> 5.2'
  s.add_runtime_dependency 'net-telnet', '~> 0.1'
  s.add_runtime_dependency 'rainbow', '~> 3.0'
  s.add_runtime_dependency 'thor', '~> 0.20'
  s.add_runtime_dependency 'terminal-table', '~> 1.8'

  s.add_development_dependency 'minitest', '~> 5.11'
  s.add_development_dependency 'rubocop', '~> 0.74'

  s.post_install_message = "Thanks for installing!"
end
