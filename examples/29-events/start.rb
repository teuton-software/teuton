group "Work with events" do
  target "Create user vader"
  run "id vader"
  expect_ok

  event on: "last_target", when: "fail" do
    log "OK"
  end
end

play do
  show
  export
end
