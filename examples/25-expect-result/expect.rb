group "Examples: expect" do
  target "Expect text(/bin/zsh) in SOME output lines"
  run "cat /etc/passwd"
  expect "/bin/zsh"

  target "Expect text(root) in inly ONE output lines"
  run "cat /etc/passwd"
  expect_one "/bin/zsh"

  target "Expect text(/bin/zsh) in NONE output lines"
  run "cat /etc/passwd"
  expect_none "/bin/fish"
end
