
task "OpenSUSE external configurations" do
  set :master_ip, "172.18." + get(:number).to_i.to_s + ".100"

  target "ping to <"+get(:master_ip)+">"
  goto :localhost, :exec => "ping #{get(:master_ip)} -c 2"
  expect result.find!('64 bytes from').ge(1)

  target "SSH port 22 on <"+get(:master_ip)+"> open"
  goto :localhost, :exec => "nmap #{get(:master_ip)} -Pn"
  expect result.find!("ssh").count!.eq(1)
end

task "OpenSUSE student configurations" do
  shortname = "master" + get(:number).to_s
  target "Checking hostname -a <"+shortname+">"
  goto :master, :exec => "hostname -a"
  expect result.equal?(shortname)

  domainname = get(:master_domain).to_s
  target "Checking hostname -d <"+domainname+">"
  goto :master, :exec => "hostname -d"
  expect result.equal?(domainname)

  fullname= shortname+"."+domainname
  target "Checking hostname -f <"+fullname+">"
  goto :master, :exec => "hostname -f"
  expect result.equal?(fullname)

  username=get(:username)

  target "User <#{username}> exists"
  goto :master, :exec => "cat /etc/passwd"
  expect result.find!(username).count!.eq(1)

  target "Users <#{username}> with not empty password "
  goto :master, :exec => "cat /etc/shadow | grep '#{username}:' | cut -d : -f 2| wc -l"
  expect result.eq(1)

  target "User <#{username}> logged"
  goto :master, :exec => "last | grep #{username[0,8]} | wc -l"
  expect result.neq(0)

  goto :master, :exec => "blkid |grep sda1"
  unique "master_UUID_sda1", result.value
  goto :master, :exec => "blkid |grep sda2"
  unique "master_sda2", result.value
end

task "OpenSUSE network configurations" do
  goto :master, :exec => "ip a|grep ether"
  mac= result.value
  log    ("master_MAC = #{mac}")
  unique "MAC", mac

  target "Gateway <#{get(:gateway_ip)}>"
  goto   :master, :exec => "route -n"
  expect result.find!("UG").find!(get(:gateway_ip)).count!.eq 1

  target "WWW routing OK"
  goto   :master, :exec => "ping 88.198.18.148 -c 1"
  expect result.find!(" 0% packet loss,").count!.eq 1

  target "DNS OK"
  goto   :master, :exec => "nslookup www.iespuertodelacruz.es"
  expect result.find!("Address:").find!("88.198.18.148").count!.eq 1
end
