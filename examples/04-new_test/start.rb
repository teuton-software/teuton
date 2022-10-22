group "Create new test" do
  target "Exist </home/vader> directory"
  run "file /home/vader", on: :host1
  expect_none "No such file or directory"
end

play do
  show
  export
end
