
task "OpenSUSE external configurations" do
  set :client1_username, "root"

  target "ping to <"+get(:client1_ip)+">"
  goto :localhost, :exec => "ping #{get(:client1_ip)} -c 2"
  expect result.find!('64 bytes from').ge(1)

  target "SSH port 22 on <"+get(:client1_ip)+"> open"
  goto :localhost, :exec => "nmap #{get(:client1_ip)} -Pn"
  expect result.find!("ssh").count!.eq(1)
end

task "OpenSUSE student configurations" do
  shortname = "cli1alu" + get(:number).to_s
  target "Checking hostname -a <"+shortname+">"
  goto :client1, :exec => "hostname -a"
  expect result.equal?(shortname)

  domainname = get(:client1_domain).to_s
  target "Checking hostname -d <"+domainname+">"
  goto :client1, :exec => "hostname -d"
  expect result.equal?(domainname)

  fullname= shortname+"."+domainname
  target "Checking hostname -f <"+fullname+">"
  goto :client1, :exec => "hostname -f"
  expect result.equal?(fullname)

  username=get(:username)

  target "User <#{username}> exists"
  goto :client1, :exec => "cat /etc/passwd"
  expect result.find!(username).count!.eq(1)

  target "Users <#{username}> with not empty password "
  goto :client1, :exec => "cat /etc/shadow | grep '#{username}:' | cut -d : -f 2| wc -l"
  expect result.eq(1)

  target "User <#{username}> logged"
  goto :client1, :exec => "last | grep #{username[0,8]} | wc -l"
  expect result.neq(0)

  goto :client1, :exec => "blkid |grep sda1"
  unique "client1_UUID_sda1", result.value
  goto :client1, :exec => "blkid |grep sda2"
  unique "client1_sda2", result.value
end

task "OpenSUSE network configurations" do
  goto :client1, :exec => "ip a|grep ether"
  mac= result.value
  log    ("client1_MAC = #{mac}")
  unique "MAC", mac

  target "Gateway <#{get(:gateway_ip)}>"
  goto   :client1, :exec => "route -n"
  expect result.find!("UG").find!(get(:gateway_ip)).count!.eq 1

  target "WWW routing OK"
  goto   :client1, :exec => "ping 88.198.18.148 -c 1"
  expect result.find!(" 0% packet loss,").count!.eq 1

  target "DNS OK"
  goto   :client1, :exec => "nslookup www.iespuertodelacruz.es"
  expect result.find!("Address:").find!("88.198.18.148").count!.eq 1
end
