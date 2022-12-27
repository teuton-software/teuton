group "Preserve output reports" do
  target "Exits user root"
  run "id root"
  expect "root"
end

play do
  show
  export format: "txt", feedback: false
  export format: "yaml", feedback: false
  export format: "html", feedback: false
end
