group "Events: stop" do
  target "Target ok"
  run "id root"
  expect_ok

  target "Target fail"
  run "id vader"
  expect_ok

  event on: :last_target, when: :failed do
    stop
  end

  target "Target ok"
  run "id root"
  expect_ok
end

play do
  show
  export
end
