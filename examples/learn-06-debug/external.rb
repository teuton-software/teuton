
group "Windows: external configuration" do

  target "ENsure connectivity with #{gett(:windows1_ip)} is ok"
  run    "ping #{get(:windows1_ip)} -c 1"
  result.debug
  expect_one "0% packet loss"
  result.debug

  target "Ensure netbios-ssn service is working on #{gett(:windows1_ip)}"
  run    "nmap -Pn #{get(:windows1_ip)}"
  expect [ "139/tcp", "open" ]

end
