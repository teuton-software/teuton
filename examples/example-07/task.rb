
task "Create user obiwan" do

  target "Checking user <obiwan>"
  goto :localhost, :exec => "id obiwan| wc -l"
  expect result.equal(1)

end
