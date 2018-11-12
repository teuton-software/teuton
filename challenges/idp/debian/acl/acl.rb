
task "ACL permisos <endor>" do

  dir = '/mnt/starwars/endor'
  permisos = [ 'user::rwx', 'user:han:rwx', 'user:luke:r-x',
    'group::---', 'group:troopers:rwx', 'mask::rwx', 'other::---']

  target "Comprobar propietario de #{dir}"
  goto :debian1, :exec => "stat #{dir}"
  expect result.grep("Uid").grep("root").count.eq 1

  goto :debian1, :exec => "getfacl #{dir}"

  permisos.each do |line|
    target "Comprobar que getfacl #{dir} incluye <#{line}>"
    expect result.grep(line).count.eq 1
    result.restore!
  end

end

task "ACL permisos <xwing>" do

  dir = '/mnt/starwars/xwing'
  permisos = [ 'user::rwx', 'user:han:rwx', 'user:luke:r-x',
    'group::---', 'mask::rwx', 'other::---']

  target "Comprobar propietario de #{dir}"
  goto :debian1, :exec => "stat #{dir}"
  expect result.grep("Uid").grep("root").count.eq 1

  goto :debian1, :exec => "getfacl #{dir}"

  permisos.each do |line|
    target "Comprobar que getfacl #{dir} incluye <#{line}"
    expect result.grep(line).count.eq 1
    result.restore!
  end

end
