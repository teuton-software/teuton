
group "Read exit code (RIGHT)" do
  target "No user vader"
  run "id vader;echo $?"
  result.last
  expect_one "1"

  target "Exist user root"
  run "id root;echo $?"
  expect_one result.last.eq(0)
end
