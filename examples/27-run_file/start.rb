group "Learn about run_file" do
  target "Running script exitcode"
  run_file "bash script/exitcode.sh 6", on: :host1
  expect_exit 6

  target "Running script show"
  run_file "bash script/show.sh HelloWorld1", on: :host1
  expect "HelloWorld1"

  target "Upload file and then run it"
  upload "script/show.sh", remotefile: "show.sh", to: :host1
  run "bash show.sh HelloWorld2", on: :host1
  expect "HelloWorld2"

  upload "a.out", to: :host1
end

start do
  show
  export
end
