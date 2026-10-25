group "Events: scores_to_zero" do
  target "Target ok"
  run "id root"
  expect_ok

  target "Target ok"
  run "id root"
  expect_ok

  target "Target fail"
  run "id vader"
  expect_ok

  event on: :last_target, when: :failed do
    scores_to_zero
  end
end

play do
  show
  export
end
