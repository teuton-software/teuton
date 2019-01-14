# encoding: utf-8

task "Target 01" do

  target "Create user <" + get(:username) + ">"
  request "You have to create a new user STUDENTNAME."
  run "id " + get(:username)
  expect result.count.equal?(1)

end

play do
  show
  export
end
