use "macro"

group "Learn about run_file" do
  target "Example 1: Running script exitcode"
  run_file "bash script/exitcode.sh 6", on: :host1
  expect_exit 6

  target "Example 2: Running script show"
  run_file "bash script/show.sh HelloWorld2", on: :host1
  expect "HelloWorld2"

  target "Example 3: Upload file and then run it"
  upload "script/show.sh", remotefile: "show.sh", to: :host1
  run "bash show.sh HelloWorld3", on: :host1
  expect "HelloWorld3"

  target "Example 4: using macro"
  run_script file: "script/show.sh", shell: "bash", args: "HelloWorld4", on: :host1
  expect "HelloWorld4"

  upload "a.out", to: :host1
end

start do
  show
  export
end
