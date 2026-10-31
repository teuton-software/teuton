group "Windows: internal configurations" do
  target "Ensure Windows version is #{get(:windows_version)}"
  run "ver", on: :windows
  expect ["Windows", get(:windows_version)]

  target "Ensure Windows COMPUTERNAME is #{get(:windows_hostname)}"
  run "set", on: :windows
  expect ["COMPUTERNAME", get(:windows_hostname)]

  target "Configure gateway with #{get(:gateway)}"
  run "ipconfig", on: :windows
  expect ["enlace", get(:gateway)]

  target "Ensure gateway is working"
  run "ping #{get(:dns)}", on: :windows
  expect result.find("Respuesta").count.eq 4

  target "Ensure DNS is working"
  run "nslookup www.iespuertodelacruz.es", on: :windows
  expect ["Address:", "88.198.18.148"]
end
