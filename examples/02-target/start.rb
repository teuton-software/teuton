group "Practicing targets" do
  target "Create user obiwan"
  run "id obiwan"
  expect ["uid=", "(obiwan)", "gid="]

  target "Delete user vader", weight: 2
  run "id vader"
  expect_fail
end

play do
  show
  export
end
