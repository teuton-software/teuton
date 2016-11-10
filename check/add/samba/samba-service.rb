
task "Samba external configurations" do
  target "Samba ports on <"+get(:host2_ip)+"> open"
  goto :localhost, :exec => "nmap #{get(:host2_ip)} -Pn"
  expect result.grep!("smb").grep!("open").count!.eq(1)
end
