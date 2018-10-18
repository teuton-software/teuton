
=begin
 State       : In progress...
 Activity    : SSH conections
 MV OS       : GNU/Linux Debian 7
 Spanish URL : https://github.com/dvarrui/libro-de-actividades/blob/master/actividades/add/ssh/README.md
=end

task "Configure SSH Server" do

  target "authorized_keys en usuario4 <#{get(:lastname)}4>"
  goto   :host2, :exec => "vdir /home/#{get(:lastname)}4/.ssh/authorized_keys| wc -l"
  expect result.equal(1)

  goto   :host2, :exec => "cat /home/#{get(:lastname)}4/.ssh/id_rsa.pub", :tempfile => "mv1_idrsapub.tmp"
  @filename1 = tempfile

  set(:client1_hostname, 'ssh-client'+get(:number).to_s+"g")
	set(:client1_ip,       '172.18.'+get(:number).to_i.to_s+".32")
	set(:client2_hostname, 'ssh-client'+get(:number).to_s+"w")
	set(:client2_ip,        '172.18.'+get(:number).to_i.to_s+".11")

  goto   :host2, :exec => "cat /etc/hosts"
	target "#{get(:client1_hostname)} hostname defined on SSH Server"
  result.restore!
  expect result.find!(get(:client1_hostname)).find!(get(:client1_ip)).count!.equal(1)
  target "#{get(:client2_hostname)} hostname defined on SSH Server"
  result.restore!
  expect result.find!(get(:client2_hostname)).find!(get(:client2_ip)).count!.equal(1)

end

task "SSH Server users" do

  usernames = [ get(:lastname)+"1", get(:lastname)+"2", get(:lastname)+"3", get(:lastname)+"4" ]

  usernames.each do |username|
    target "Exist username <"+username+">"
    goto :host2, :exec => "id #{username}"
    expect result.count!.equal(1)
  end

end

=begin

task "Configure OpenSUSE SSH" do

  target "Permissions /home/#{get(:firstname)}/.ssh => rwx------"
  goto :host2, :exec => "vdir -a /home/#{get(:firstname)}/ | grep '.ssh'| grep 'rwx------'| wc -l"
  expect result.equal(1)

  goto :host2, :exec => "cat /home/#{get(:firstname)}/.ssh/authorized_keys", :tempfile => "mv2_authorizedkeys.tmp"
  filename2=tempfile

  target "mv2(authorized_keys) == mv1(id_rsa.pub)"
  goto :localhost, :exec => "diff #{@filename1} #{filename2}| wc -l"
  expect result.equal?(0)

  target "mv2: Host1 hostname defined"
  goto :host2, :exec => "cat /etc/hosts| grep #{get(:host1_hostname)}| grep #{get(:host1_ip)}| wc -l"
  expect result.equal?(1)

end


task "Do git clone into OpenSUSE host" do

  target "Git installed on <#{get(:host1_ip)}>"
  goto :host1, :exec => "dpkg -l git| grep 'ii'| wc -l"
  expect result.equal?(1)

  #target "Proyect from GitHub cloned on <#{get(:host1_ip)}>"
  #on :host1, :exec => "vdir -a /home/#{get(:username)}/add1314profesor/ | grep '.git'| wc -l"
  #check result.to_i.equal?(1)

  target "Git installed on <#{get(:host2_ip)}>"
  goto :host2, :exec => "git --version| grep git |grep version| wc -l"
  expect result.equal?(1)

  target "Proyect from GitHub cloned on <#{get(:host2_ip)}>"
  goto :host2, :exec => "vdir -a /home/#{get(:firstname)}/add1314profesor/unit.1/ | grep '.exam_remoto'| wc -l"
  expect result.equal?(1)

  log "Tests finished"
end
=end
