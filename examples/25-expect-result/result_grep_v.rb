group "Examples: expect with result grep_v" do
  target "Expect <=7 lines in output"
  run "cat /etc/passwd"
  expect result.grep_v("/sbin/nologin").count.le 7
end
