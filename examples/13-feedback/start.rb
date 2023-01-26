group "Preserve output reports" do
  target "Exits user david"
  run "id david"
  expect "david"
end

play do
  show
  export feedback: false
  export format: "html", feedback: false
end
