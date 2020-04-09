define_macro 'package_installed', :package do
  ostype = get(:ostype) || :opensuse

  if ostype == :opensuse
    target "#{get(:package)} installed"
    run "zypper info #{get(:package)}"
    expect_one [ 'Estado:', 'actualizado' ]
  end
end

define_macro 'package_not_installed', :package do
  ostype = get(:ostype) || :opensuse

  if ostype == :opensuse
    target "#{get(:package)} not installed"
    run "zypper info #{get(:package)}"
    expect_one [ 'Estado:', 'no se ha instalado' ]
  end
end
