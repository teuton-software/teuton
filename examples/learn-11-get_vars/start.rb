
group "Ways to read config vars" do

	target "Exist #{get(:dirname)} directory"
	run "file #{get(:dirname)}"
	expect_none "No such file or directory"

	target "Exist #{_dirname} directory"
	run "file #{_dirname}"
	expect_none "No such file or directory"

	dirname = get(:dirname)
	target "Exist #{dirname} directory"
	run "file #{dirname}"
	expect_none "No such file or directory"
end

play do
  show
  export
end
