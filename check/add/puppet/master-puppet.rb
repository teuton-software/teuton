
task "Master check hostnames" do
  set :client1_ip, "172.18." + get(:number).to_i.to_s + ".101"
  set :client2_ip, "172.18." + get(:number).to_i.to_s + ".102"

  goto :master, :exec => "cat /etc/hosts"

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

task "Master software" do
  packages = ['rubygem-puppet-master', 'rubygem-puppet']

  packages.each do |packagename|
    target "<" + packagename + "> installed"
    goto :master, :exec => "zypper se #{packagename}"
    expect result.find!('ii ').find!(packagename).ge(1)
  end

  goto :master, :exec => "systemctl status puppetmaster"
  target "Service <puppetmaster> active"
  result.restore!
  expect result.find!('Active: ').find!('running').eq(1)

  target "Service <puppetmaster> enable"
  result.restore!
  expect result.find!('Loaded: ').find!(' enable').eq(1)
end

task "Master: puppet files" do
  target "<site.pp> created"
  goto :master, :exec => "file /etc/puppet/manifests/site.pp"
  expect result.find!('ASCII text ').eq(1)

  files = ['hostlinux1.pp', 'hostlinux2.pp', 'hostwindows3.pp', 'hostwindows4.pp']

  files.each do |filename|
    target "<" + filename + "> created"
    goto :master, :exec => "file /etc/puppet/manifests/classes/#{filename}"
    expect result.find!('ASCII text ').eq(1)
  end
end

task "Master: certificates" do
  certname = "cli1alu" + get(:number).to_s + '.' + get(:client1_domain)
  target "Certificates <#{certname}> accepted"
  goto :master, :exec => "puppet cert print #{certname}"
  expect result.count!.neq(0)

  certname = 'cli2alu' + get(:number)
  target "Certificates <#{certname}> accepted"
  goto :master, :exec => "puppet cert print #{certname}"
  expect result.count!.neq(0)
end
