group "Capture exit code" do
  target "Right execution: user exist"
  run "id root"
  expect_exit 0

  target "Wrong execution: user no exist"
  run "id vader"
  expect_exit 1

  target "Using a range"
  run "id vader"
  expect_exit 1..3

  target "Using an array"
  run "id vader"
  expect_exit [1, 3, 7]
end
