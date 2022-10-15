
group "group name 1" do

  target "target 1"
  run "id obiwan"
  expect_one "obiwan"

  target "target 2"
  run "id yoda"
  expect result.count.eq 1

  target "target 3"
  run "cat /etc/passwd"
  expect result.find("vader").count.eq 1

  target "target 4"
  run "cat /etc/passwd"
  expect result.find(/obiwan|obi-wan/).count.eq 1
end

play do
  show
  export
end
