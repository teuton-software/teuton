group "NFS Settings" do
  username = get(:username)
  password = get(:password)

  set(:win1_username, username)
  set(:win1_password, password)
  set(:win1_hostname, "#{get(:hostname1)}#{get(:number)}s")

  set(:win2_username, username)
  set(:win2_password, password)
  set(:win2_hostname, "#{get(:hostname2)}#{get(:number)}w")

  set(:lin1_username, username)
  set(:lin1_password, password)
  set(:lin1_hostname, "#{get(:hostname1)}#{get(:number)}g")

  set(:lin2_username, username)
  set(:lin2_password, password)
  set(:lin1_hostname, "#{get(:hostname2)}#{get(:number)}g")
end

group "NFS GNU/Linux" do

  goal "NFS Service active"
  goto :lin1, :exec => "systemctl status nfs-kernel-server"
  expect result.grep!("active").count!.equal(1), :weight => 2

  goal "NFS public resource"
  goto :lin1, :exec => "showmount -e #{get(:lin1_ip)}"
  expect result.grep!("/srv/exports#{get(:number)}/public").count!.equal(1)

  goal "NFS private resource"
  goto :lin1, :exec => "showmount -e #{get(:lin1_ip)}"
  expect result.grep!("/srv/exports#{get(:number)}/private").count!.equal(1)
end

start do
  show    # Muestra el resumen de resultados en el terminal
  export  # Generar ficheros de salida detallados
end
