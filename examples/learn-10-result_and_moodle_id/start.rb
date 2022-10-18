group "Using result object" do
  # Capturing hostname value
  run "hostname"
  hostname = result.value

  target "Hostname must be #{hostname}"
  run "hostname"
  expect hostname
end

group "Checking users" do
  users = ["root", "vader"]

  users.each do |name|
    target "Exists username #{name}"
    run "id #{name}"
    expect "(#{name})"
  end
end

play do
  show
  export
end
