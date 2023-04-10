group "Learn about targets" do
  target "Create user david"
  run "id david"
  expect ["uid=", "(david)", "gid="]

  target "Delete user vader"
  run "id vader"
  expect ["id:", "vader", "no exist"]
end

start do
  show
  export
end
