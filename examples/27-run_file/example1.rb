# Example 1
#   Using run_file to upload local script
#   and then execute it on remote host
#
group "Learn about run_file" do
  target "Example 1: Running script exitcode"
  run_file "bash script/exitcode.sh 6", on: :host1
  expect_exit 6

  target "Example 2: Running script show"
  run_file "bash script/show.sh HelloWorld2", on: :host1
  expect "HelloWorld2"

  target "Example 3: Upload file and then run it"
  upload "script/show.sh", remotepath: "show.sh", to: :host1
  run "bash show.sh HelloWorld3", on: :host1
  expect "HelloWorld3"

  upload "a.out", to: :host1
end
