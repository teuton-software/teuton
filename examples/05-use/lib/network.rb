group "Using file: network" do
  target "Update computer name with #{get(:hostname)}"
  run "hostname", on: :host1
  expect_one get(:hostname)

  target "Ensure DNS Server is working"
  run "host www.google.es", on: :host1
  expect "www.google.es has address "
end
