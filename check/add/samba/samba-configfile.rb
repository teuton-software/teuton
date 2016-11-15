
task "Samba configuration file" do
  shares = []
  shares << { :group => get(:share1_group), :resource => get(:share1_resource) }
  shares << { :group => get(:share2_group), :resource => get(:share2_resource) }

  goto   :server, :exec => "cat /etc/samba/smb.conf"
  basepath = File.join("/", "srv", "samba"+get(:id))

  shares.each do |share|
    resource = share[:resource]
    group    = share[:group]
    dirname  = resource+".d"
    dirpath  = File.join( basepath, dirname)

    target "Section #{resource}"
    result.restore!
    expect result.grep!("[#{resource}]").count!.eq(1)

    target "valid users"
    result.restore!
    expect result.grep!("valid users").grep!(group).count!.eq(1)

    target "read only = no"
    result.restore!
    expect result.grep!("read only").grep!("no").count!.ge(2)
  end
end
