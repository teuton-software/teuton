
task "ACL Discos" do

  target "Disco sda"
  goto :debian1, :exec => "lsblk"
  expect result.grep("sda").count.eq 6

  target "Disco sdb"
  result.restore!
  expect result.grep("sdb").count.eq 2

  target "/etc/fstab"
  goto :debian1, :exec => "cat /etc/fstab"
  expect result.grep("/dev/sdb1").grep("/mnt/starwars").count.eq 1

  target "Partición sdb1 montada en /mnt/starwars"
  result.restore!
  expect result.grep("sdb").grep("/mnt/starwars").count.eq 1

end
