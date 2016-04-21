
task "TASK NAME" do

  target "TARGET DESCRIPTION"
  goto :localhost, :exec => "COMMAND"
  expect result.equal(1)

end

start do
  show
  export
end
