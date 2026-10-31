group "Preserve output reports" do
  target "Create user david"
  run "id david"
  expect_ok
end

play do
  show
  export preserve: true
end
