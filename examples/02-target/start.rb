group "Learn about targets" do
  target "Create user root"
  run "id root"
  expect ["uid=", "(root)", "gid="]

  target "Delete user vader"
  run "id vader"
  expect ["id:", "vader", "no exist"]
end

start do
  show
  export
end
