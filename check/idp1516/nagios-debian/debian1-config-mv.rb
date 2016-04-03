# encoding: utf-8

task "Configure host Debian1" do

  target "ping #{get(:debian1_ip)} to Debian"
  goto :localhost, :exec => "ping #{get(:debian1_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

  target "SSH port 22 on <"+get(:debian1_ip)+"> open"
  goto :localhost, :exec => "nmap #{get(:debian1_ip)} -Pn | grep ssh|wc -l"
  expect result.eq 1

  @student_number=get(:debian1_ip).split(".")[2]||"999"
  @student_number="0"+@student_number if @student_number.size==1
  @short_hostname=[]
  @short_hostname[1]="#{get(:lastname1)}#{@student_number}g"
  
  target "Checking hostname -a <"+@short_hostname[1]+">"
  goto :debian1, :exec => "hostname -a"
  expect result.eq @short_hostname[1]

  target "Checking hostname -d <"+get(:domain)+">"
  goto :debian1, :exec => "hostname -d"
  expect result.eq get(:domain)

  @long_hostname=[]
  @long_hostname[1]="#{@short_hostname[1]}.#{get(:domain)}"
  
  target "Checking hostname -f <"+@long_hostname[1]+">"
  goto :debian1, :exec => "hostname -f"
  expect result.eq @long_hostname[1]

  target "Exists user <#{get(:firstname)}"
  goto :debian1, :exec => "cat /etc/passwd | grep '#{get(:firstname)}:' |wc -l"
  expect result.gt 0

  target "Gateway <#{get(:gateway)}"
  goto :debian1, :exec => "route -n|grep UG|grep #{get(:gateway)} |wc -l"
  expect result.eq 1

  target "DNS <#{get(:dns)}> is running"
  goto :debian1, :exec => "ping #{get(:dns)} -c 1| grep '1 received' |wc -l"
  expect result.gt 0

  target "DNS works!"
  goto :debian1, :exec => "host www.iespuertodelacruz.es |grep 'has address' |wc -l"
  expect result.gt 0

  goto :debian1, :exec => "blkid |grep sda1"
  unique "UUID_sda1", result.value	

  @uuid_debian1=result.value
end


