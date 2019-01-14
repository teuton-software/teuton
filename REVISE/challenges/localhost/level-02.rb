# encoding: utf-8

group "Target 02" do

  target "Create user <"+get(:username)+">"
  request "Debes crear el usuario <NOMBREALUMNO>"
  run "id #{get(:username)}"
  expect result.count!.equal?(1), :weight => 2.0

  target "Member of group <"+get(:groupname)+">"
  request "Además el usuario creado debe ser miembro del grupo VBoxUsers"
  run "id #{get(:username)}"
  expect result.find!(get(:groupname)).count!.equal?(1)

end

play do
#  show
  export
end
