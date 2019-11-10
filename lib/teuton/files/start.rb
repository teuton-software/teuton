
group "GROUP NAME" do

  target "TARGET-1 DESCRIPTION"
  goto :localhost, :exec => "COMMAND-1"
  expect "TEXT-1"

end

play do
  show
  export
end
