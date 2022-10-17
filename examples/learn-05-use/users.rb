group "Use file: User configuration" do
  target "Create user #{gett(:username)}"
  run "net user", on: :host1
  expect get(:username)
end
