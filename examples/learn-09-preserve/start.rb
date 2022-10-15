
group "Preserve output reports" do

  target "Exits obiwan user "
  run "id obiwan"
  expect "obiwan"

end

play do
  show
  export preserve: true
end
