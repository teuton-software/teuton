
group "Demo new test" do

	target "Exist #{_dirname_} directory"
	run "file #{_dirname_}"
	expect_none "No such file or directory"

  puts _dirname
	puts _dirname_
end

play do
  show
  export
end
