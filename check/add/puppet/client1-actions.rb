
task "Client1: puppet actions" do
  packages = ['tree', 'traceroute', 'geany']

  packages.each do |packagename|
    target "<" + packagename + "> installed"
    goto :client1, :exec => "zypper se #{packagename}"
    expect result.find!('i ').find!(packagename).count!.ge(1)
  end

  username = 'barbaroja'
  target "User <#{username}>"
  goto :client1, :exec => "id #{username}"
  expect result.count!.eq(1)

  groups = ['piratas', 'admin']
  goto :client1, :exec => 'cat /etc/group'
  groups.each do |groupname|
    target "Group <" + groupname + ">"
    result.restore!
    expect result.find!(groupname+':').count!.eq(1)
  end
end
