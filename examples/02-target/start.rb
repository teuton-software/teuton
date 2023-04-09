group "Learn about targets" do
  target "Create user david"
  run "id david"
  expect ["uid=", "(david)", "gid="]
end

start do
  show
  export
end
