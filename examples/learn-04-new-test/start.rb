
group "GROUP NAME" do

	target "Exist </home/david> directory"
	run "file /home/david", :on => :host1
	expect ["/home/david", "directory"]

end

play do
  show
  export
end
