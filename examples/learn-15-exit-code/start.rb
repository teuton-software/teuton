
group "Read exit code" do

  cmd = "id vader"
  target "No user vader"
  run cmd + ";echo $?"
  result.debug
  expect_one result.eq(1)

  cmd = "id root"
  target "Exist user root"
  run cmd + ";echo $?"
  result.last!
  result.debug
  expect_one result.eq(0)
end

play do
  show
  export
end
