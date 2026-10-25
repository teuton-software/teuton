group "Events: stop" do
  target "Target 1: ok"
  run "id root"
  expect_ok

  target "Target 2: ok"
  run "id root"
  expect_ok

  target "Target 3: fail"
  run "id vader"
  expect_ok

  event on: :last_target, when: :failed do
    stop
  end

  target "Target 4: ok"
  run "id root"
  expect_ok
end

play do
  show
  export
end
