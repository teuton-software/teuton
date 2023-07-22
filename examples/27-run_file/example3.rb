# Example 3
#  Using DSL to upload several files
#  and then run every remote script
#
group "Example 3: Learn about run_file" do
  upload "script/*", to: :host1

  target "Example 3.1: Running script exitcode"
  run "sh exitcode.sh 6", on: :host1
  expect_exit 6

  target "Example 3.2: Running script show"
  run "sh show.sh HelloWorld2", on: :host1
  expect "HelloWorld2"
end
