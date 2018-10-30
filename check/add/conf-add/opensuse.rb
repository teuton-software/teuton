# encoding: utf-8

task 'General' do
  target "Checking SSH port <"+get(:host1_ip)+">"
  run "nmap -Pn #{get(:host1_ip)}"
  expect result.find!('ssh').find!('open').count!.eq(1)

  unique "hostname", result.value
  goto  :host1, :exec => "blkid |grep sda1"
  unique "UUID", result.value
end

task 'user_definitions' do
  username=get(:firstname)

  target "User <#{username}> exists"
  goto  :host1, :exec => "id #{username}"
  expect result.count!.eq(1)

  target "Users <#{username}> with not empty password "
  goto  :host1, :exec => "cat /etc/shadow | grep '#{username}:' | cut -d : -f 2"
  expect result.count!.eq(1)

  target "User <#{username}> logged"
  goto  :host1, :exec => "last | grep #{username[0,8]} | wc -l"
  expect result.neq(0)
end

task 'network_configuration' do

  target "gateway configuration"
  goto  :host1, :exec => "ping 8.8.4.4 -c 1"
  expect result.find!("64 bytes from 8.8.4.4").count!.eq(1)

  target "DNS configuration"
  goto  :host1, :exec => "host www.nba.com"
  expect result.find!("has address").count!.gt(0)
end
