group "Capture exit code" do
  target "Right execution: user exist"
  run "id root"
  expect_exit 0

  target "Right execution: user exist"
  run "id root"
  expect_ok

  target "Wrong execution: user no exist"
  run "id vader"
  expect_exit 1

  target "Wrong execution: user no exist"
  run "id vader"
  expect_fail

  target "Using a range"
  run "id vader"
  expect_exit 1..3

  target "Using a list"
  run "id vader"
  expect_exit [1, 3, 7]
end
