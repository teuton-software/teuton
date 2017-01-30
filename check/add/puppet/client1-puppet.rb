
task "Client1 check hostnames" do

  goto :client1, :exec => "cat /etc/hosts"

  target "master info into /etc/hosts file"
  result.restore!
  expect result.find!(get(:master_ip)).find!('master'+get(:number)).find!(get(:master_domain)).eq(1)

  target "client1 info into /etc/hosts file"
  result.restore!
  expect result.find!(get(:client1_ip)).find!('cli1alu'+get(:number)).find!(get(:client1_domain)).eq(1)

  target "client2 into /etc/hosts file"
  result.restore!
  expect result.find!(get(:client2_ip)).find!('cli2alu'+get(:number)).find!(get(:client2_domain)).eq(1)
end

task "Client1 software" do
  packages = ['rubygem-puppet']

  packages.each do |packagename|
    target "<" + packagename + "> installed"
    goto :client1, :exec => "zypper se #{packagename}"
    expect result.find!('ii ').find!(packagename).ge(1)
  end

  goto :master, :exec => "systemctl status puppet"
  target "Service <puppet> active"
  result.restore!
  expect result.find!('Active: ').find!('running').eq(1)

  target "Service <puppet> enable"
  result.restore!
  expect result.find!('Loaded: ').find!(' enable').eq(1)
end

task "Client1: puppet.conf files" do
  target "puppet.conf"
  goto :client1, :exec => "cat /etc/puppet/puppet.conf"
  expect result.find!('server').find!('master'+get(:number)).eq(1)
end
