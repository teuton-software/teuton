group "Test remote Windows hosts" do
  target "Update hostname with #{gett(:host1_hostname)}"
  run "hostname", on: :host1
  expect_one get(:host1_hostname)

  target "Ensure network DNS configuration is working"
  run "nslookup www.google.es", on: :host1
  expect "Nombre:"

  target "Create user #{gett(:username)}"
  run "net user", on: :host1
  expect get(:username)
end

play do
  show
  # export using other output formats
  export :format => :txt
  export :format => :json
  send :copy_to => :host1
end
