group "Using result object" do
  # Capturing hostname value
  run "hostname"
  hostname = result.value

  target "No #{hostname} user"
  run "id hostname"
  expect_none hostname
end

group "Checking users" do
  users = ["root", "vader"]

  users.each do |name|
    target "Exists username #{name}"
    run "id #{name}"
    result.debug
    expect "(#{name})"
  end
end
