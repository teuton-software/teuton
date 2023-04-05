group "Using result object" do
  # Reading: Capturing remote hostname
  run "hostname"
  hostname = result.value

  # Checking: No remote user equal to hostname
  target "No #{hostname} user"
  run "id #{hostname}"
  expect_none hostname
end

group "Checking users" do
  users = ["root", "vader"]

  for name in users do
    # Checking: Exist user
    target "Exists username #{name}"
    run "id #{name}"
    expect "(#{name})"
  end
end
