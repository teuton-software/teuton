group "Using file: users" do
  target "Create user #{get(:username)}"
  run "id #{get(:username)}", on: :host1
  expect ["uid=", "(" + get(:username) + ")", "gid="]
end
