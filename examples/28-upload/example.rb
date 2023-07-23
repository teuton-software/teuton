#  Upload several files and then run every remote script
#
group "Learn about upload" do
  upload "script/*", to: :host1

  target "Running script exitcode"
  run "sh exitcode.sh 6", on: :host1
  expect_exit 6

  target "Running script show"
  run "sh show.sh HelloWorld2", on: :host1
  expect "HelloWorld2"
end
