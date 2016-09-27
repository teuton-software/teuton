
=begin
   Course name : ...
 Activity name : ...
         MV OS : ...
    Teacher OS : ...
   English URL : ...
   Spanish URL : ...
=end 

task "TASK NAME" do

  target "TARGET DESCRIPTION"
  goto :localhost, :exec => "COMMAND"
  expect result.equal(1)

end

start do
  show
  export
end
