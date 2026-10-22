group "Work with events" do
  target "Create user vader"
  run "id vader"
  expect_ok

  event on: :last_target, when: :failed do
    stop
  end

  target "Create user quigon"
  run "id quigon"
  expect_fail
end

play do
  show
  export
end
