require_relative 'lib/teuton/application'

Gem::Specification.new do |s|
  s.name        = Application::NAME
  s.version     = Application::VERSION
  s.date        = '2019-11-13'
  s.summary     = "Teuton (Teuton Software)"
  s.description = <<-EOF
  Intrastructure Test Software.

  Some dependencies require compilation.
  Ensure these packages are installed into your local hosts:
  [ALL] ruby, make, gcc
  [Debian] ssh, ruby-dev
  [OpenSUSE] openssh, ruby-devel

  Read Teuton documentation: https://github.com/teuton-software/teuton/wiki/
  EOF

  s.extra_rdoc_files = [ 'README.md', 'docs/logo.png' ]

  s.license     = 'GPL-3.0'
  s.authors     = ['David Vargas Ruiz']
  s.email       = 'teuton.software@protonmail.com'
  s.homepage    = 'https://github.com/teuton-software/teuton'

  s.executables << 'teuton'
#  s.executables << 'teuton.bat'
  s.files       = Dir.glob(File.join('lib','**','*.rb'))

  s.required_ruby_version = '>= 2.3.0'

  s.add_runtime_dependency 'json_pure', '~> 2.2'
  s.add_runtime_dependency 'net-sftp', '~> 2.1'
  s.add_runtime_dependency 'net-ssh', '~> 5.2'
  s.add_runtime_dependency 'net-telnet', '~> 0.1'
  s.add_runtime_dependency 'rainbow', '~> 3.0'
  s.add_runtime_dependency 'thor', '~> 0.20'
  s.add_runtime_dependency 'terminal-table', '~> 1.8'

  s.add_development_dependency 'minitest', '~> 5.11'
  s.add_development_dependency 'rubocop', '~> 0.74'
end
