
group "learn-10-alias" do
  target "Verify user #{get(:super)} with key alias."
  run "id #{get(:super)}"
  expect get(:super)

  target "Verify user #{username?} with method alias."
  run "id #{username?}"
  expect username?
end

play do
  show
  export
end
