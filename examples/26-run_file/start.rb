group "Learn about run_file" do
  target "Running script exitcode"
  run_file "bash script/exitcode.sh 6", on: :host1
  expect_exit 6

  target "Running script echo"
  run_file "bash script/show.sh HelloWorld", on: :host1
  expect "HelloWorld"

  upload "a.out", to: :host1
  upload "script/show.sh", remotefile: "show.sh", to: :host1
end

start do
  show
  export
end
