group "NFS Settings" do
  username = get(:username)
  password = get(:password)

  set(:mv1_username, username)
  set(:mv1_password, password)
  hostname = get(:hostname1)+get(:number)
  set(:mv1_hostname, hostname)

  set(:mv2_username, username)
  set(:mv2_password, password)
  hostname = get(:hostname2)+get(:number)
  set(:mv2_hostname, hostname)

  set(:mv3_username, username)
  set(:mv3_password, password)
  hostname = get(:hostname3)+get(:number)
  set(:mv3_hostname, hostname)
end

group "NFS Activity" do
  goal "Servicio NFS activo en MV1 (Fran)"
  # info: install nks-kernel-server
  goto :mv1, :exec => "systemctl status nfs-kernel-server"
  goto :mv1, :exec => "echo $?"
  expect result.equal("0")

  goal "Servicio NFS activo en la MV1 (David)"
  # info: install nks-kernel-server
  goto :mv1, :exec => "systemctl status nfs-kernel-server"
  expect result.grep!("active").count!.equal(1)
end

start do
  show    # Muestra el resumen de resultados en el terminal
  export  # Generar ficheros de salida detallados
end
