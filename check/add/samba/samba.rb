
task "Samba external configurations" do
  target "Samba ports on <"+get(:host2_ip)+"> open"
  goto :localhost, :exec => "nmap #{get(:host2_ip)} -Pn"
  expect result.grep!("smb").grep!("open").count!.eq(1)
end

task "Samba users group1" do
  group1_name = get(:group1_name)
  group1_users = get(:group1_users).split(",")

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

task "Shares directories" do
  sharename = get(:group1_share)
  sharepath = File.join("/","srv","sea"+get(:number),sharename+".d")

  target "Directory #{sharepath}> exist"
  goto :host2, :exec => "file #{sharepath}"
  expect result.grep!("directory").count!.eq(1)
end

task "Samba configuration file" do
  sharename = get(:group1_share)
  sharepath = File.join("/","srv","sea"+get(:number),sharename+".d")

  target "Directory #{sharepath}> exist"
  goto :host2, :exec => "cat #{sharepath}"
  expect result.grep!("path").grep!("=").count!.eq(1)

end
