
task "Members of group1" do
  group_name = get(:group1_name)
  group_users = get(:group1_users).split(",")

  group_users.each do |username|
    target "System User <#{username}> exists"
    goto   :host2, :exec => "id #{username}"
    expect result.count!.eq(1)

    target "User <#{username}> member of <#{group_name}>"
    result.restore!
    expect result.grep!(group_name).count!.eq(1)

    target "Samba User <#{username}> exists"
    goto   :host2, :exec => "pdbedit -L"
    expect result.grep!(username).count!.eq(1)

    target "Valid user line"
    goto   :host2, :exec => "cat /etc/samba/smb.conf"
    expect result.grep!("valid user").grep!(username).count!.eq(1)
  end
end

task "Members of group2" do
  group_name = get(:group2_name)
  group_users = get(:group2_users).split(",")

  group_users.each do |username|
    target "System User <#{username}> exists"
    goto   :host2, :exec => "id #{username}"
    expect result.count!.eq(1)

    target "User <#{username}> member of <#{group_name}>"
    result.restore!
    expect result.grep!(group_name).count!.eq(1)

    target "Samba User <#{username}> exists"
    goto   :host2, :exec => "pdbedit -L"
    expect result.grep!(username).count!.eq(1)

    target "Valid user line"
    goto   :host2, :exec => "cat /etc/samba/smb.conf"
    expect result.grep!("valid user").grep!(group_name).count!.eq(1)
  end
end
