group "Several output reports formats" do
  target "Exits user obiwan"
  run "id obiwan"
  expect ["uid", "gid", "obiwan"]
end

play do
  show
  export format: "txt"
  export format: "html"
  export format: "json"
end
