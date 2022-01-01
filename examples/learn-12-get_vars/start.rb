
group "Demo new test" do

	target "Exist #{_dirname} directory"
	run "file #{_dirname}"
	expect_none "No such file or directory"

end

play do
  show
  export
end
