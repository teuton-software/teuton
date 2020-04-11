
group "Using config file values" do

  target "Create user #{gett(:username)}"
  run "id #{get(:username)}"
  expect get(:username)

end

play do
  show
  export
end
