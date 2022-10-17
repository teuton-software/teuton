group "Read exit code" do
  target "No user vader"
  run "id vader;echo $?"
  expect_last "1"

  target "Exist user root"
  run "id root;echo $?"
  expect_last "0"
end

play do
  show
  export
end
