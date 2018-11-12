# encoding: utf-8

task 'General' do
  target "Checking SSH port <"+get(:host1_ip)+">"
  run "nmap -Pn #{get(:host1_ip)}"
  expect result.find!('ssh').find!('open').count!.eq(1)

  goto  :host1, :exec => "hostname"
  unique "hostname", result.value
  goto  :host1, :exec => "blkid |grep sda1"
  unique "UUID", result.value
end
