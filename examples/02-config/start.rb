group "Reading params from config file" do
  target "Create user #{get(:username)}"
  run "id #{get(:username)}"
  expect get(:username)
end

play do
  show verbose: 4
  export
end
