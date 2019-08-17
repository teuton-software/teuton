
group "group name 1" do

  target "target 1"
  goto :localhost, :exec => "id obiwan"
  expect_one "obiwan"

  target "target 2"
  goto :localhost, :exec => "id yoda"
  expect result.count.eq 1

  target "target 3"
  goto :localhost, :exec => "cat /etc/passwd"
  expect result.find("vader").count.eq 1

  target "target 4"
  goto :localhost, :exec => "cat /etc/passwd"
  expect result.find(/obiwan|obi-wan/).count.eq 1
end

play do
  show
  export
end
