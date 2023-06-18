group "Examples: expect" do
  target "Expect text(/bin/zsh) in SOME output lines"
  run "cat /etc/passwd"
  expect "/bin/zsh"

  target "Expect text(root) in only ONE output lines"
  run "cat /etc/passwd"
  expect_one "/bin/zsh"

  target "Expect sequence OK"
  run "cat /etc/hosts"
  expect_sequence do
    find "127.0.0.1"
    next_with "# fallback"
    find "# special"
    next_with "::1"
  end
end
