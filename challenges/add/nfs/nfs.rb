task "Settings" do

  username = get(:username)
  password = get(:password)
  set(:mv1_username, username)
  set(:mv2_username, username)
  set(:mv3_username, username)
  set(:mv1_password, password)
  set(:mv2_password, password)
  set(:mv3_password, password)

end

task "NFS" do

  target "Instalar el servicio NFS en MV1"
  goto :mv1, :exec => "systemctl status nfs-kernel-server"
  goto :mv1, :exec => "echo $?"
  expect result.grep("0").equal(1)

end

start do
  show    # esto es para mostrar los resultados en consola
#  export
end
