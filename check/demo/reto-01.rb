# encoding: utf-8

task "Target 01" do

  target "Create user <"+get(:username)+">"
  run "id #{get(:username)}"
  expect result.count!.equal?(1)

end

start do
  show
  export
end
