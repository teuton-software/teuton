group "Hide feedback from reports" do
  target "Exits user root"
  run "id root"
  expect "root"
end

play do
  show
  export format: "yaml", feedback: false
  export format: "txt", feedback: true
  export format: "html", feedback: false
end
