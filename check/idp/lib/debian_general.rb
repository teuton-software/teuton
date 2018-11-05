
task 'General' do
  target "Checking SSH port <"+get(:debian1_ip)+">"
  run "nmap -Pn #{get(:debian1_ip)}"
  expect result.find!('ssh').find!('open').count!.eq(1)
end
