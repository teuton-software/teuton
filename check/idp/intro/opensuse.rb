
task "OpenSUSE external configurations" do
  target "ping to <"+get(:host2_ip)+">"
  goto :localhost, :exec => "ping #{get(:host2_ip)} | grep errors|wc -l"
  expect result.eq(0)

  target "SSH port 22 on <"+get(:host2_ip)+"> open"
  goto :localhost, :exec => "nmap #{get(:host2_ip)} -Pn | grep ssh|wc -l"
  expect result.eq(1)
end

task "OpenSUSE Internal configurations" do
  goto :host1, :exec => "blkid |grep sda1"
  unique "UUID_sda1", result.value
  goto :host1, :exec => "blkid |grep sda2"
  unique "UUID_sda2", result.value
  goto :host1, :exec => "blkid |grep sda6"

end

task "OpenSUSE student configurations"
  shortname = get(:apellido1).to_s + get(:number).to_s + "g"
  target "Checking hostname -a <"+shortname+">"
  goto :host2, :exec => "hostname -a"
  expect result.equal?(shortname)

  domainname = get(:host2_domain).to_s
  target "Checking hostname -d <"+domainname+">"
  goto :host2, :exec => "hostname -d"
  expect result.equal?(domainname)

  fullname= shortname+"."+domainname
  target "Checking hostname -f <"+fullname+">"
  goto :host2, :exec => "hostname -f"
  expect result.equal?(fullname)

  username=get(:username)

  target "User <#{username}> exists"
  goto :host2, :exec => "cat /etc/passwd | grep '#{username}:' | wc -l"
  expect result.eq(1)

  target "Users <#{username}> with not empty password "
  goto :host2, :exec => "cat /etc/shadow | grep '#{username}:' | cut -d : -f 2| wc -l"
  expect result.eq(1)

  target "User <#{username}> logged"
  goto :host2, :exec => "last | grep #{username[0,8]} | wc -l"
  expect result.neq(0)
end
