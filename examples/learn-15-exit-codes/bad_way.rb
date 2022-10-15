
group "Read exit code (bad way)" do
  log "DON'T DO THIS WAY"

  target "No user vader"
  run "id vader"
  run "echo $?"
  result.last
  result.debug
  expect_one "1"

  target "Exist user root"
  run "id root"
  run "echo $?"
  result.last
  result.debug
  expect_one "0"
end
