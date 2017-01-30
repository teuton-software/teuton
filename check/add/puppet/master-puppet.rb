

task "Master check hostnames" do
  set :client1_ip, "172.18." + get(:number).to_i.to_s + ".101"
  set :client2_ip, "172.18." + get(:number).to_i.to_s + ".102"

  goto :master, :exec => "cat /etc/hosts"

  target "Master conf into etc hosts file"
  result.restore!
  expect result.find!(get(:master_ip)).find!('master').eq(1)

  target "Master conf into etc hosts file"
  result.restore!
  expect result.find!(get(:client1_ip)).find!('client1').eq(1)

  target "Master conf into etc hosts file"
  result.restore!
  expect result.find!(get(:client2_ip)).find!('client2').eq(1)
end

task "Master installed software" do
  packages = ['rubygems-puppet-master', 'rubygems-puppet']

  packages.each do |package|
    target "<" + package + "> installed"
    goto :master, :exec => "zypper se #{package}"
    expect result.find!('ii ').find!(package).ge(1)
  end
end

task "Master manifest files" do
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
