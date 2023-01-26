group "Windows: external configuration" do
  target "Ensure connectivity with #{get(:windows_ip)} is ok"
  run "ping #{get(:windows_ip)} -c 1"
  result.debug
  expect_one "0% packet loss"
  result.debug

  target "Ensure netbios-ssn service is working on #{get(:windows_ip)}"
  run "nmap -Pn #{get(:windows_ip)}"
  expect ["139/tcp", "open"]
end
