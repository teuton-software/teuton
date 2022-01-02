
group "Learn about targets" do

  target "Create user david"
  run "id david 2>/dev/null"
  expect "david"

end

start do
  show
  export
end
