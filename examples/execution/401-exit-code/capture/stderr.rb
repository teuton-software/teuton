group "Capture stderr command output" do
  target "Right execution: ls"
  run "ls"
  expect result.count.gt 0

  target "Wrong execution: sl"
  run "sl"
  expect "No such file"
end
