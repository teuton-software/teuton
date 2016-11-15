
task "Service external" do
  target "Samba ports on <"+get(:server_ip)+"> open"
  goto   :localhost, :exec => "nmap -Pn #{get(:server_ip)}"
  expect result.grep!("139/tcp").grep!("open").count!.eq(1)

  result.restore!
  expect result.grep!("445/tcp").grep!("open").count!.eq(1)

  goto   :localhost, :exec => 'smbtree -N'

  shares = [ 'IPC$', get(:share1_resource), get(:share2_resource), get(:share3_resource) ]
  shares.each do |share|
    target "sbmtree -N -> #{share}"
    result.restore!
    expect result.grep!("SAMBA#{get(:id)}").grep!(share).count!.eq(1)
  end

  target "sbm service"
  goto   :server, :exec => 'systemctl status smb'
  expect result.grep!("Active:").grep!("active").grep!("(running)").count!.eq(1)

  target "nbm service"
  goto   :server, :exec => 'systemctl status nmb'
  expect result.grep!("Active:").grep!("active").grep!("(running)").count!.eq(1)
end
