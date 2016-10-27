
=begin
 State       : In progress...
 Activity    : SSH conections
 MV OS       : GNU/Linux Debian 7
 Spanish URL : https://github.com/dvarrui/libro-de-actividades/blob/master/actividades/add/ssh/README.md
=end

task "Configure SSH Server" do

  target "Claves privada y pública en usuario <#{get(:firstname)}>"
  goto   :host2, :exec => "vdir /home/#{get(:firstname)}/.ssh/id_*| wc -l"
  expect result.equal(2)

  goto   :host2, :exec => "cat /home/#{get(:firstname)}/.ssh/id_rsa.pub", :tempfile => "mv1_idrsapub.tmp"
  @filename1 = tempfile

  set(:client1_hostname, 'ssh-client'+get(:number).to_s+"a")
	set(:client1_ip,       '172.18.'+get(:number).to_i.to_s+"32")
	set(:client2_hostname, 'ssh-client'+get(:number).to_s+"b")
	set(:client2_ip,        '172.18.'+get(:number).to_i.to_s+"11")

	target "#{clienteNameA} hostname defined on SSH Server"
  goto   :host2, :exec => "cat /etc/hosts"
  expect result.find!(get(:client1_hostname)),find!(get(:client1_ip)).count!.equal(1)

end


=begin

task "Configure OpenSUSE host" do

  target "Zona horaria <WET #{get(:year)}>"
  goto :host2, :exec => "date | grep WET | grep #{get(:year)} | wc -l"
  expect result.equal(1)

  target "OS OpenSuse 64 bits"
  goto :host2, :exec => "uname -a| grep opensuse| grep x86_64| wc -l"
  expect result.equal(1)

  target "Value hostname == "+get(:host2_hostname)+" "
  goto :host2, :exec => "hostname -a"
  expect result.equal(get(:host2_hostname))

  target "Value domainname == "+get(:lastname)+" "
  goto :host2, :exec => "hostname -d"
  expect result.equal(get(:lastname))

  target "Exist username <"+get(:firstname)+">"
  goto :host2, :exec => "cat /etc/passwd|grep '"+get(:firstname)+"'|wc -l"
  expect result.equal(1)

  target "Checking groupname <"+get(:groupname)+">"
  goto :host1, :exec => "cat /etc/group|grep '"+get(:groupname)+"'|wc -l"
  expect result.equal(1)

  target "User maingroup == "+get(:groupname)+" "
  goto :host1, :exec => "id "+get(:firstname)+"| tr -s ' ' ':'| cut -d : -f 2| grep "+get(:groupname)+"|wc -l"
  expect result.equal(1)

end

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

task "Configure Debian VNC server" do

  target "Tightvncserver installed on <#{get(:host1_ip)}>"
  goto :host1, :exec => "dpkg -l tightvncserver| grep 'ii'| wc -l"
  expect result.equal(1)

  goto :localhost, :exec => "nmap -Pn #{get(:host1_ip)}", :tempfile => 'mv1_nmap.tmp'
  filename = tempfile

  #command "ps -ef| grep tightvnc| grep geometry| wc -l", :tempfile => 'tightvnc.tmp'
  #vncserver :1

  target "Services 'vnc' on <#{get(:host1_ip)}>"
  goto :localhost, :exec => "cat #{filename}|grep 'vnc'| wc -l"
  expect result.equal(1)

  target "Services active on ip/port #{get(:host1_ip)}/6001"
  goto :localhost, :exec => "cat #{filename} |grep '6001'| wc -l"
  expect result.equal(1)

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

start do
	show
	export
  send :copy_to => :host2
end

=begin
---
:global:
  :groupname: udremote
  :host1_username: root
  :host1_hostname: debian
  :host2_username: root
  :host2_hostname: opensuse
  :year: '2015'
:cases:
- :tt_members: David Vargas
  :firstname: david
  :lastname: vargas
  :host1_ip: 172.16.109.101
  :host1_password: toor
  :host2_ip: 172.16.109.201
  :host2_password: toor
...
=end
