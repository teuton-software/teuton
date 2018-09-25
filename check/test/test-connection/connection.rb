
task "GNU/Linux connections" do

  set(:host1_ip, get(:host_ip))
  set(:host2_ip, get(:host_ip))
  set(:host3_ip, get(:host_ip))
  set(:host4_ip, get(:host_ip))

  target "host1 SSH with <#{get(:host1_username)}> "
  goto   :host1, :exec => "ip a"
  expect result.find!(get(:host1_ip)).count!.eq 1

  target "host2 SSH with <#{get(:host2_username)}> "
  goto   :host2, :exec => "ip a"
  expect result.find!(get(:host2_ip)).count!.eq 1

  target "host3 Telnet with <#{get(:host3_username)}> "
  goto   :host3, :exec => "ip a"
  expect result.find!(get(:host3_ip)).count!.eq 1

  target "host4 Telnet with <#{get(:host4_username)}> "
  goto   :host4, :exec => "ip a"
  expect result.find!(get(:host4_ip)).count!.eq 1
  
end
