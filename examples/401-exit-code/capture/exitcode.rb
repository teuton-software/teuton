group "Capture exit code" do
  target "Right execution: root user exist"
  run "id root"
  expect_exit 0

  target "Right execution: root user exist"
  run "id root"
  expect_ok

  target "Wrong execution: vader user no exist"
  run "id vader"
  expect_exit 1

  target "Wrong execution: vader user no exist"
  run "id vader"
  expect_fail

  target "Using a range: vader no exist"
  run "id vader"
  expect_exit 1..3

  target "Using a list: vader no exist"
  run "id vader"
  expect_exit [1, 3, 7]
end
