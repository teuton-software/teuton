# encoding: utf-8

=begin
 Course name : IDP1516
 Activity    : Commands 01
 MV OS       : GNU/Linux Debian 7
=end

task :hostname_configurations do
  target "Checking SSH port <"+get(:host1_ip)+">"
  goto  :localhost, :exec => "nmap #{get(:host1_ip)} | grep ssh|wc -l"
  expect result.eq(1)

  my_hostname="#{get(:lastname1)}.#{get(:dominio)}"
  target "Checking hostname <"+my_hostname+">"
  goto  :host1, :exec => "hostname -f"
  expect result.equal?(my_hostname)

  unique "hostname", result.value
  goto  :host1, :exec => "blkid |grep sda1"
  unique "UUID", result.value
end

task :user_definitions do
  username=get(:usersname)

  target "User <#{username}> exists"
  goto  :host1, :exec => "cat /etc/passwd | grep '#{username}:' | wc -l"
  expect result.eq(1)

  target "Users <#{username}> with not empty password "
  goto  :host1, :exec => "cat /etc/shadow | grep '#{username}:' | cut -d : -f 2| wc -l"
  expect result.eq(1)

  target "User <#{username}> logged"
  goto  :host1, :exec => "last | grep #{username[0,8]} | wc -l"
  expect result.neq(0)
end
