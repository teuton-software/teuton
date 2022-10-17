group "Preserve output reports" do
  target "Exits user obiwan"
  run "id obiwan"
  expect "obiwan"
end

play do
  show
  export preserve: true
end
