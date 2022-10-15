
group "Reading params from config file" do

  target "Create user #{get(:username)}"
  run "id #{get(:username)} 2>/dev/null"
  expect get(:username)

end

play do
  show
  export
end
