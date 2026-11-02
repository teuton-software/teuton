# Example 1
#   Upload local script and then execute it on remote host
#
group "Learn about run_script" do
  target "Example 1: Running script exitcode"
  run_script "bash script/exitcode.sh 1", on: :host1
  expect_exit 1

  target "Example 2: Running script exitcode"
  run_script "script/exitcode.sh", shell: "bash", args: "2", on: :host1
  expect_exit 2

  target "Example 3: Running script show"
  run_script "bash script/show.sh HelloWorld3", on: :host1
  expect "HelloWorld3"

  target "Example 4: Running script show"
  run_script "script/show.sh", shell: "bash", args: "HelloWorld4", on: :host1
  expect "HelloWorld4"

  target "Example 5: Default shell"
  set(:shell, "bash")
  run_script "script/show.sh", args: "HelloWorld4", on: :host1
  expect "HelloWorld4"
end
