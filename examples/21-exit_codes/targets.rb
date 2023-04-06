group "Howto read exit code" do
  target "No user vader"
  run "id vader;echo $?"
  expect_last "1"

  target "Exist user root"
  run "id root;echo $?"
  expect_last "0"
end

group "Capture stderr" do 
  target "Right execution: ls"
  run "ls"
  expect result.count.gt 0

  target "Wrong execution: sl"
  run "sl"
  expect "No such file"
end
