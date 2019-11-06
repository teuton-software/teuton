
group "Network configuracion" do

  target "Update computer name with #{gett(:host1_hostname)}"
  goto   :host1, :exec => "hostname"
  expect_one get(:host1_hostname)

  target "Ensure DNS Server is working"
  goto   :host1, :exec => "nslookup www.google.es"
  expect "Nombre:"

end
