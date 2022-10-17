group "Demo new test" do
	target "Exist </home/david> directory"
	run "file /home/david", :on => :host1
	expect_none "No such file or directory"
end

play do
  show
  export
end
