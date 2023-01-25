group "Using file: users" do
  target "Create user #{get(:username)}"
  run "id #{get(:username)}", on: :host1
  expect get(:username)
end
