
group "Use file: User configuration" do

  target "Create user #{gett(:username)}"
  goto   :host1, :exec => "net user"
  expect get(:username)

end
