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
