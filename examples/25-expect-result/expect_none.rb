group "Examples: expect_none" do
  target "Expect text(/bin/zsh) in NONE output lines"
  run "cat /etc/passwd"
  expect_none "/bin/fish"

  target "Expect text(/bin/zsh) in NONE output lines"
  run "cat /etc/passwd |grep /bin/fish"
  expect_none

  target "Expect text(/bin/zsh) in NONE output lines"
  run "cat /etc/passwd |grep /bin/fish"
  expect_nothing
end
