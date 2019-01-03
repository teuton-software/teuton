
task "GNU/Linux Settings" do

  hostname="#{get(:lastname1)}#{get(:number)}g1.#{get(:dominio)}"
  set(:linux1_hostname, hostname)

  hostname="#{get(:lastname1)}#{get(:number)}g2.#{get(:dominio)}"
  set(:linux2_hostname, hostname)

end
