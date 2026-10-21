group "Include several config files" do
  target "Ensure exists username #{get(:username)}"
  run "id #{get(:username)}"
  expect_ok
end

play do
  show
  export
end
