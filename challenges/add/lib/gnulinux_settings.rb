
task "OpenSUSE Settings" do

  hostname="#{get(:lastname1)}#{get(:number)}g1.#{get(:dominio)}"
  set(:suse1_hostname, hostname)

  hostname="#{get(:lastname1)}#{get(:number)}g2.#{get(:dominio)}"
  set(:suse2_hostname, hostname)

end
