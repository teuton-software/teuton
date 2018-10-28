# encoding: utf-8

task "Target 02" do

  target "Create user <"+get(:username)+">"
  run "id #{get(:username)}"
  expect result.count!.equal?(1), :weight => 2.0

  target "Member of group <"+get(:groupname)+">"
  run "id #{get(:username)}"
  expect result.find!(get(:groupname)).count!.equal?(1)

end

start do
#  show
  export
end
