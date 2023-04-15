group "Capture exit code" do
  target "Right execution: id root"
  run "id root"
  expect_exit 0

  target "Wrong execution: id vader"
  run "id vader"
  expect_exit 1
end
