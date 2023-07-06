group "Learn about run_file" do
  target "Running script exitcode"
  run_file "script/exitcode 6", host: :host1
  expect_exit 6

  target "Running script echo"
  run_file "script/echo HelloWorld", host: :host1
  expect "HelloWorld"
end

start do
  show
  export
end
