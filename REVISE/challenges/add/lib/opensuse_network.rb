# encoding: utf-8

task 'network_configuration' do

  target "gateway configuration"
  goto  :host1, :exec => "ping 8.8.4.4 -c 1"
  expect result.find!("64 bytes from 8.8.4.4").count!.eq(1)

  target "DNS configuration"
  goto  :host1, :exec => "host www.nba.com"
  expect result.find!("has address").count!.gt(0)
end
