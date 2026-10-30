group "Zero weight target" do
  target "Target 1: ok"
  run "id root"
  expect_ok

  target "Target 2: ok"
  run "id root"
  expect_ok

  target "Target 3: ok", weight: 0
  run "id root"
  expect_ok

  target "Target 4: ok"
  run "id root"
  expect_ok
end

play do
  show
  export
end
