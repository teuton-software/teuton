
task "winserver domain groups" do

  groups= [ 'jedi', 'sith']
  domains=get(:domain).split(".")
  names= []
  
  groups.each do |group|
    names << "CN=#{group},CN=Users,DC=#{domains[0]},DC=#{domains[1]}"
  end
  
  goto :winserver, :exec => "dsquery group domainroot"
  names.each do |name|
    target "Domain group <#{name}>"
    result.restore!
    expect result.find!(name).count!.eq 1
  end
end

task "winserver domain users" do

  users= [ 'obiwan', 'maul']
  domains=get(:domain).split(".")
  names= []
  
  users.each do |user|
    names << "CN=#{user},CN=Users,DC=#{domains[0]},DC=#{domains[1]}"
  end
  
  goto :winserver, :exec => "dsquery user domainroot"
  names.each do |name|
    target "Domain user <#{name}>"
    result.restore!
    expect result.find!(name).count!.eq 1
  end
end

task "winserver domain computers" do

  computers= [ get(:wincli1_sname).upcase, get(:wincli2_sname).upcase]
  domains=get(:domain).split(".")
  names= []
  
  computers.each do |user|
    names << "CN=#{user},CN=Computers,DC=#{domains[0]},DC=#{domains[1]}"
  end
  
  goto :winserver, :exec => "dsquery computer domainroot"
  names.each do |name|
    target "Domain computer <#{name}>"
    result.restore!
    expect result.find!(name).count!.eq 1
  end
end

task "winserver profiles" do

  target "Profile Directory <#{get(:profiles_dir)}>"
  goto   :winserver, :exec => "dir e:"
  expect result.find!(get(:profiles_dir)).find!("DIR").count!.eq 1

  users= [ 'obiwan', 'maul' ]
  goto   :winserver, :exec => "dir e:\\#{get(:profiles_dir)}"
  users.each do |user|  
    target "Profile Directory for user <#{user}>"
    result.restore!
    expect result.find!(user).find!(".V2").count!.eq 1
  end
  
end
