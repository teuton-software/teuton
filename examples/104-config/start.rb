group "Reading params from config file" do
  target "Create user #{get(:username)}"
  run "id #{get(:username)}"
  expect ["uid=", "(" + get(:username) + ")", "gid="]
end

play do
  show
  export
end
