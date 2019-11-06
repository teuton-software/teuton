
group "Windows: internal configurations" do

  target "Ensure Windows version is 6.1"
  goto   :windows1, :exec => "ver"
  expect "Windows", "6.1"

  target "Ensure Windows COMPUTERNAME is #{gett(:windows1_hostname)}"
  goto   :windows1, :exec => "set"
  expect "COMPUTERNAME", get(:windows1_hostname)

  target "Configure gateway with #{gett(:gateway)}"
  goto   :windows1, :exec => "ipconfig"
  expect "enlace", get(:gateway)

  target "Ensure gateway is working"
  goto   :windows1, :exec => "ping #{get(:dns)}"
  expect result.find("Respuesta").count.eq 4

  target "Ensure DNS is working"
  goto   :windows1, :exec => "nslookup www.iespuertodelacruz.es"
  expect "Address:", "88.198.18.148"
end
