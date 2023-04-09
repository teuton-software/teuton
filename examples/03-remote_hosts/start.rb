group "Remote host" do
  target "Create user david"
  run "id david", on: :host1
  expect ["uid=", "(david)", "gid="]
end

play do
  show
  export
end
