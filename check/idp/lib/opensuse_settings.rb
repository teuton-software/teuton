
task "Settings" do

  hostname="#{get(:lastname1)}#{get(:number)}g.#{get(:dominio)}1"
  set(:suse1_hostname, hostname)

end
