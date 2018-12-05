# encoding: utf-8

task "Target 03" do

  username = "david"
  groupname = "users"

  target "Create user <"+ username+">"
  request "Must create user <#{username}>"
  run "id #{username}"
  expect result.count!.equal?(1)

  target "Member of group <"+ groupname+">"
  request "User <#{username}> must be member of <#{groupname}>"
  result.restore!
  expect result.grep!(groupname).count!.equal?(1)

  home = "/home/" + username

  target "User home is <" + home + ">"
  request "User <#{username}> must have home directory as <#{home}>"
  run "cat /etc/passwd"
  expect result.grep!(home).grep!(username).count!.equal?(1)
end

start do
  show
  export
end
