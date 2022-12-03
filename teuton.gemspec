require_relative "lib/teuton/version"

Gem::Specification.new do |s|
  s.name = Teuton::GEMNAME
  s.version = Teuton::VERSION
  s.summary = "Teuton (Infrastructure test)"
  s.description = <<-EOF
  Intrastructure test, useful for:
  (1) Sysadmin teachers to evaluate students remote machines.
  (2) Sysadmin apprentices to evaluate their learning process as a game.
  (3) Professional sysadmin to monitor remote machines.

  Allow us:
  (a) Write test units for real or virtual machines using simple DSL.
  (b) Check compliance with requirements on remote machines.
  EOF

  s.extra_rdoc_files = ["README.md", "LICENSE"] + Dir.glob(File.join("docs", "**", "*.md"))

  s.license = "GPL-3.0"
  s.authors = ["David Vargas Ruiz"]
  s.email = "teuton.software@protonmail.com"
  s.homepage = Teuton::HOMEPAGE

  s.executables << "teuton"
  s.files = Dir.glob(File.join("lib", "**", "*.*"))

  s.required_ruby_version = ">= 2.5.9"

  s.add_runtime_dependency "colorize", "~> 0.8.1"
  s.add_runtime_dependency "rainbow", "~> 3.0"
  s.add_runtime_dependency "net-sftp", "~> 2.1"
  s.add_runtime_dependency "net-ssh", "~> 5.0"
  s.add_runtime_dependency "net-telnet", "~> 0.1"
  s.add_runtime_dependency "json_pure", "~> 2.2"
  s.add_runtime_dependency "thor", "~> 1.2"
  s.add_runtime_dependency "terminal-table", "~> 1.8"
end
