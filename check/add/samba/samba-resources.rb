
task "Resources" do
  shares = []
  shares << { :group => get(:share1_group), :resource => get(:share1_resource), :perm => get(:share1_perm) }
  shares << { :group => get(:share2_group), :resource => get(:share2_resource), :perm => get(:share2_perm) }

  basepath = File.join( "/", "srv", "samba"+get(:id) )
  target "Directory #{basepath}> exist"
  goto :server, :exec => "file #{basepath}"
  expect result.grep!("directory").count!.eq(1)

  shares.each do |share|
    resource = share[:resource]
    perm     = share[:perm]
    dirname  = resource+".d"
    dirpath  = File.join( basepath, dirname)

    target "Directory #{dirpath}> exist"
    goto :server, :exec => "file #{dirpath}"
    expect result.grep!("directory").count!.eq(1)

    target "Permissions #{dirpath}> #{perm}"
    goto :server, :exec => "vdir #{basepath}"
    expect result.grep!(dirname).grep!(perm).count!.eq(1)
  end
end
