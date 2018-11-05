
task 'network_configuration' do

  target "gateway configuration"
  goto  :linux1, :exec => "ping 8.8.4.4 -c 1"
  expect result.find!("64 bytes from 8.8.4.4").count!.eq(1)

  target "DNS configuration"
  goto  :linux1, :exec => "host www.nba.com"
  expect result.find!("has address").count!.gt(0)
end
