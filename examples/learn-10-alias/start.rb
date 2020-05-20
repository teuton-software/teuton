
group "Using alias" do

  target "Verify user #{get(:super)} with key alias."
  run "id #{get(:super)}"
  expect get(:super)

  target "Verify user #{_username_} with method alias."
  run "id #{_username_}"
  expect _username_
end

play do
  show
  export
end
