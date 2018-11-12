# encoding: utf-8

task "Target 03" do

  username = "david"
  groupname = "users"

  target "Create user <"+ username+">"
  run "id #{username}"
  expect result.count!.equal?(1)

  target "Member of group <"+ groupname+">"
  result.restore!
  expect result.grep!(groupname).count!.equal?(1)

  home = "/home/" + username

  target "User home is <" + home + ">"
  run "cat /etc/passwd"
  expect result.grep!(home).grep!(username).count!.equal?(1)
end

start do
  show
  export
end
