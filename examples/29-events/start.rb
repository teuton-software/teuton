group "Events: stop" do
  target "Create user vader"
  run "id vader"
  expect_ok

  event on: :last_target, when: :failed do
    stop
    scores_to_zero
  end

  target "Delete user quigon"
  run "id quigon"
  expect_fail
end

play do
  show
  export
end
