group "Learn about targets" do
  target "Create user david"
  run "id david"
  expect "david"
end

start do
  show
  export
end
