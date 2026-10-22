group "Events: scores_to_zero" do
  target "Create user root"
  run "id root"
  expect_ok

  target "Create user toor"
  run "id toor"
  expect_ok

  event on: :last_target, when: :failed do
    scores_to_zero
  end
end

play do
  show
  export
end
