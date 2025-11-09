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

  s.add_runtime_dependency "json_pure", "~> 2.8"
  s.add_runtime_dependency "net-sftp", "~> 4.0"
  s.add_runtime_dependency "net-ssh", "~> 7.3"
  s.add_runtime_dependency "net-telnet", "~> 0.2"
  s.add_runtime_dependency "rainbow", "~> 3.1"
  s.add_runtime_dependency "terminal-table", "~> 4.0"
  s.add_runtime_dependency "thor", "~> 1.3"
  # s.add_runtime_dependency("ed25519", "~> 1.2") # Require ruby-devel package
  s.add_runtime_dependency("bcrypt_pbkdf", "~> 1.0") unless RUBY_PLATFORM == "java"
end
