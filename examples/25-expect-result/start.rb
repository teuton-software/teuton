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

group "Examples: expect with result count" do
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

group "Examples: expect with result grep" do
  target "Expect 0 lines in output"
  run "cat /etc/passwd"
  expect result.grep("obiwan").count.eq 0

  target "Expect >2 lines in output"
  run "cat /etc/passwd"
  expect result.grep("/bin/bash").count.gt 2

  target "Expect <10 lines in output"
  run "cat /etc/passwd"
  expect result.grep("/bin/bash").count.lt 10
end

group "Examples: expect with result grep_v" do
  target "Expect <=7 lines in output"
  run "cat /etc/passwd"
  expect result.grep_v("/sbin/nologin").count.le 7
end

play do
  show
  export
end
