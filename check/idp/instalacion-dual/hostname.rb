

task :hostname_configurations do
  #target "ping to <"+get(:host1_ip)+">"
  #goto :localhost, :exec => "ping #{get(:host1_ip)} | grep errors|wc -l"
  #expect result.eq(0)

  target "SSH port 22 on <"+get(:host2_ip)+"> open"
  goto :localhost, :exec => "nmap #{get(:host2_ip)} -Pn | grep ssh|wc -l"
  expect result.eq(1)

  _hostname="DUALX#{get(:lastname1)}"
  target "Checking hostname -a <"+_hostname+">"
  goto :host2, :exec => "hostname -a"
  expect result.equal?(_hostname)

  _hostname="#{get(:lastname2)}"
  target "Checking hostname -d <"+_hostname+">"
  goto :host2, :exec => "hostname -d"
  expect result.equal?(_hostname)

  _hostname="DUALX#{get(:lastname1)}.#{get(:lastname2)}"
  target "Checking hostname -f <"+_hostname+">"
  goto :host2, :exec => "hostname -f"
  expect result.equal?(_hostname)

  goto :host2, :exec => "blkid |grep sda1"
  unique "UUID_sda1", result.value
  goto :host2, :exec => "blkid |grep sda2"
  unique "UUID_sda2", result.value
  goto :host2, :exec => "blkid |grep sda6"
  unique "UUID_sda6", result.value
  goto :host2, :exec => "blkid |grep sda7"
  unique "UUID_sda7", result.value
end
