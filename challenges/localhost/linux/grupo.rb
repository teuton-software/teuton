
group "Target: Grupo" do

  target "Exist group <"+get(:groupname)+">"
  run "cat /etc/group"
  expect result.grep!(get(:groupname)).count!.equal?(1)

  target "Member of group <"+get(:groupname)+">"
  run "id " + get(:username)
  expect result.grep!(get(:groupname)).count!.equal?(1)

end
