
=begin
   Course name : 201617
 Activity name : Apache2 service. Installation and configuration 
         MV OS : OpenSUSE 13.2
    Teacher OS : OpenSUSE 13.2
   English URL : 
   Spanish URL : 
=end 

task "Apache2 Installation" do

  target "Apache2 installed"
  goto :host1, :exec => "zypper info apache2"
  expect result.grep!(/Instalado|Installed/).grep!(/Si|Yes/).count!.equal(1)

  target "Apache2 running"
  goto :host1, :exec => "systemctl status apache2"
  expect result.grep!("Active:").grep!("(running)").count!.equal(1)

end

task "Apache2 configuration" do

  target "Apache2 goes through  firewall"
  goto :localhost, :exec => "nmap -Pn "+ get(:host1_ip)
  expect result.grep!("80/tcp").grep!("open").grep!("http").count!.equal(1)

  target "Apache2 service run on boot"
  goto :host1, :exec => "systemctl is-enabled apache2"
  expect result.equal("enabled")

  target "index.html accesible and with content"
  goto :localhost, :exec => "curl http://#{get(:host1_ip)}/index.html"
  expect result.equal("<p>apache2 server OK</p>")

end

start do
  show
  export :format => :colored_text
end
