
group "Demo new test" do

	target "Exist #{get(:dirname)} directory"
	run "file #{get(:dirname)}"
	expect_none "No such file or directory"

end

play do
  show
  export
end
