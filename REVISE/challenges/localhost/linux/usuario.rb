
group "Target: Usuario" do

  target "Create user <"+get(:username)+">"
  run "id #{get(:username)}"
  expect result.count!.equal?(1)

  home = "/home/" + get(:username)

  target "User home is <" + home + ">"
  run "cat /etc/passwd"
  expect result.grep!(home).grep!(get(:username)).count!.equal?(1)
end
