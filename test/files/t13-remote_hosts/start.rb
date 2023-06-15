group "Remote host" do
  target "Create user root"
  run "id root", on: :host1
  expect ["uid=", "(root)", "gid="]

  target "Delete user vader"
  run "id vader", on: :host1
  # expect_none ["uid=", "(vader)", "gid="]
  expect_fail
end

play do
  show
  export feedback: true
  send copy_to: :host1, prefix: "t13-"
end
