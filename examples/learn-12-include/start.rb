group "Include several config files" do
  target "Ensure exists username #{get(:username)}"
  run "id #{get(:username)}"
  expect get(:username)
end

play do
  show
  export
end
