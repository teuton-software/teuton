group "Learn about targets" do
  target "Create user root"
  run "id root 2>/dev/null"
  expect "root"
end

play do
  show
  export
end
