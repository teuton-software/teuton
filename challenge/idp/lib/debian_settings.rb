
task "Debian Settings" do

  hostname="#{get(:lastname1)}#{get(:number)}d1.#{get(:dominio)}"
  set(:debian1_hostname, hostname)

  hostname="#{get(:lastname1)}#{get(:number)}d2.#{get(:dominio)}"
  set(:debian2_hostname, hostname)

end
