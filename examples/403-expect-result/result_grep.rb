group "Examples: expect with result grep" do
  target "Expect 0 lines in output"
  run "cat /etc/passwd"
  expect result.grep("obiwan").count.eq 0

  target "Expect 0 lines in output"
  run "cat /etc/passwd"
  expect result.grep(/[Oo]biwan|[Oo]bi-wan/).count.eq 0

  target "Expect 0 lines in output"
  run "cat /etc/passwd"
  expect result.grep(["obiwan", "kenobi"]).count.eq 0

  target "Expect >2 lines in output"
  run "cat /etc/passwd"
  expect result.grep("/bin/bash").count.gt 2

  target "Expect <10 lines in output"
  run "cat /etc/passwd"
  expect result.grep("/bin/bash").count.lt 10
end
