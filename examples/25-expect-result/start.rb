group "Examples: expect and result" do
  target "Expect text(/bin/zsh) in SOME output lines"
  run "cat /etc/passwd"
  expect "/bin/zsh"

  target "Expect text(root) in inly ONE output lines"
  run "cat /etc/passwd"
  expect_one "/bin/zsh"

  target "Expect text(/bin/zsh) in NONE output lines"
  run "cat /etc/passwd"
  expect_none "/bin/fish"

  target "Expect 0 lines in output"
  run "cat /etc/passwd | grep obiwan"
  expect result.count.eq 0

  target "Expect >2 lines in output"
  run "cat /etc/passwd | grep /bin/bash"
  expect result.count.gt 2

  target "Expect <10 lines in output"
  run "cat /etc/passwd | grep /bin/bash"
  expect result.count.lt 10
end

play do
  show
  export
end
