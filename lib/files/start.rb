
group "GROUP NAME" do

  target "TARGET-1 DESCRIPTION"
  goto :localhost, :exec => "COMMAND-1"
  expect result.grep("TEXT-1").count.equal(1)

end

play do
  show
  export
end
