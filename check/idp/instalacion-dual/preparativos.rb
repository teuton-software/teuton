
task "Preparativos" do
  set( :firstname, get(:username))
  set( :lastname1, get(:apellido1))
  set( :lastname2, get(:apellido2))
  set( :host2_ip , "172.18.#{get(:number).to_i.to_s}.31" )

  goto :host1, :exec => "blkid |grep sda1"
  unique "UUID_sda1", result.value
  goto :host1, :exec => "blkid |grep sda2"
  unique "UUID_sda2", result.value
  goto :host1, :exec => "blkid |grep sda6"
  unique "UUID_sda6", result.value
  goto :host1, :exec => "blkid |grep sda7"
  unique "UUID_sda7", result.value
end
