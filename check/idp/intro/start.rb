
=begin
   Course name : ...
 Activity name : ...
         MV OS : ...
    Teacher OS : ...
   English URL : ...
   Spanish URL : ...
=end

task "Windows external configuration" do

  goto   :localhost, :exec => "nmap -Pn #{get(:host1_ip)}" #Execute command once

  ports=[ [ '23/tcp' , 'telnet'],
          [ '139/tcp', 'netbios-ssn'] ]

  ports.each do |port|
    target "windows #{get(:host1_ip)} port #{port[0]}"
    result.restore!
    expect result.grep!(port[0]).grep!("open").grep!(port[1]).count!.eq(1)
  end

end

start do
  show
  export
end
