
task 'General' do
  target "Checking SSH port <"+get(:host1_ip)+">"
  run "nmap -Pn #{get(:host1_ip)}"
  expect result.find!('ssh').find!('open').count!.eq(1)
end
