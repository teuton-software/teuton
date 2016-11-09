
task "Samba external configurations" do
  target "Samba ports on <"+get(:host2_ip)+"> open"
  goto :localhost, :exec => "nmap #{get(:host2_ip)} -Pn"
  expect result.grep!("smb").grep!("open").count!.eq(1)
end

task "Samba users" do
  group1_name = get(:group1_name)
  group1_users = get(:group1_users).split(",")

  group2_name = get(:group2_name)
  group2_users = get(:group2_users).split(",")

  group1_users.each do |username|
    target "System User <#{username}> exists"
    goto :host2, :exec => "id #{username}"
    expect result.count!.eq(1)

    target "User <#{username}> member of <#{group1_name}>"
    result.restore!
    expect result.grep!(group1_name).count!.eq(1)

    target "Samba User <#{username}> exists"
    goto :host2, :exec => "pdbedit -L"
    expect result.grep!(username).count!.eq(1)
  end
end
