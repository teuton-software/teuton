
task :hostname_configurations do
  target "Checking SSH port <"+get(:host1_ip)+">"
  goto  :localhost, :exec => "nmap #{get(:host1_ip)} | grep ssh|wc -l"
  expect result.eq(1)

  _hostname="#{get(:lastname1)}.#{get(:lastname2)}"
  target "Checking hostname <"+_hostname+">"
  goto  :host1, :exec => "hostname -f"
  expect result.equal?(_hostname)

  unique "hostname", result.value
  goto  :host1, :exec => "blkid |grep sda1"
  unique "UUID", result.value
end

task :user_definitions do
  username=get(:firstname)

  target "User <#{username}> exists"
  goto  :host1, :exec => "cat /etc/passwd | grep '#{username}:' | wc -l"
  expect result.eq(1)

  target "Users <#{username}> with not empty password "
  goto  :host1, :exceute => "cat /etc/shadow | grep '#{username}:' | cut -d : -f 2| wc -l"
  expect result.eq(1)

  target "User <#{username}> logged"
  goto  :host1, :exec => "last | grep #{username[0,8]} | wc -l"
  expect result.neq(0)
end
