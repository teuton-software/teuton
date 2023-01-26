group "Several output reports formats" do
  target "Exits user david"
  run "id david"
  expect "david"
end

play do
  show
  export format: "txt"
  export format: "html"
  export format: "json"
end
