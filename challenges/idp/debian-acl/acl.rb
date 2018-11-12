
task "ACL permisos" do

  dir1 = 'mnt/starwars/endor'
  dir2 = 'mnt/starwars/xwing'

  permisos1 = [ 'user::rwx']

  goto :debian1, :exec => "getfacl #{dir1}"

  permisos1.each do |line|
    target "Comprobar getfacl de <#{dir1}>"
    result.restore!
    expect result.grep(line).count.eq 1
  end

end
