
group "Read exit code" do
  target "No user vader"
  run "id vader;echo $?"
  expect_one result.last.eq(1)

  target "Exist user root"
  run "id root;echo $?"
  expect_one result.last.eq(0)
end

play do
  show
  export
end
