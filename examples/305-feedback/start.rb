group "Hide feedback messages from output" do
  target "Service SSH disabled"
  run "systemctl status sshd"
  expect "disabled"
end

play do
  show
  export feedback: false
  export format: "html", feedback: false
end
