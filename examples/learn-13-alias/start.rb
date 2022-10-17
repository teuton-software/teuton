group "Using alias" do
  target "Verify user #{get(:super)} with key alias."
  run "id #{get(:super)}"
  expect get(:super)

  target "Verify user #{_username} with method alias."
  run "id #{_username}"
  expect _username
end

play do
  show
  export
end
