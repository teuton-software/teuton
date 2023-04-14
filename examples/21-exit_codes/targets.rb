group "Capture exit code on stdout" do
  target "No user vader"
  run "id vader;echo $?"
  expect_last "1"

  target "Exist user root"
  run "id root;echo $?"
  expect_last "0"
end

group "Capture stderr command output" do
  target "Right execution: ls"
  run "ls"
  expect result.count.gt 0

  target "Wrong execution: sl"
  run "sl"
  expect "No such file"
end

group "Capture exit code" do
  target "Right execution: id root"
  run "id root"
  expect_exit 0

  target "Wrong execution: id vader"
  run "id vader"
  expect_exit 1
end
