
group "GROUP NAME" do

  target "TARGET DESCRIPTION"
  goto :localhost, :exec => "COMMAND"
  expect result.equal(1)

end

play do
  show
  export
end
