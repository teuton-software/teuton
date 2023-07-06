group "Learn about targets" do
  target "Create user obiwan"
  run "id obiwan"
  expect ["uid=", "(obiwan)", "gid="]

  run_file "pwd"
  
  target "Delete user vader"
  run "id vader"
  expect_fail
end

start do
  show
  export
end
