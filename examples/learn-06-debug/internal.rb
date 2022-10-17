group "Windows: internal configurations" do

  target "Ensure Windows version is 6.1"
  run    "ver", on: :windows1
  expect [ "Windows", "6.1" ]

  target "Ensure Windows COMPUTERNAME is #{gett(:windows1_hostname)}"
  run    "set", on: :windows1
  expect [ "COMPUTERNAME", get(:windows1_hostname) ]

  target "Configure gateway with #{gett(:gateway)}"
  run    "ipconfig", on: :windows1
  expect [ "enlace", get(:gateway) ]

  target "Ensure gateway is working"
  run    "ping #{get(:dns)}", on: :windows1
  expect result.find("Respuesta").count.eq 4

  target "Ensure DNS is working"
  run    "nslookup www.iespuertodelacruz.es", on: :windows1
  expect [ "Address:", "88.198.18.148" ]
end
