group "Use file: Network configuracion" do
  target "Update computer name with #{gett(:host1_hostname)}"
  run "hostname", on: :host1
  expect_one get(:host1_hostname)

  target "Ensure DNS Server is working"
  run "nslookup www.google.es", on: :host1
  expect "Nombre:"
end
