
task "Shares directories" do
  sharename = get(:group1_share)
  sharepath = File.join("/","srv","sea"+get(:number),sharename+".d")

  target "Directory #{sharepath}> exist"
  goto :host2, :exec => "file #{sharepath}"
  expect result.grep!("directory").count!.eq(1)
end

task "Samba configuration file" do
  sharename = get(:group1_share)
  sharepath = File.join("/","srv","sea"+get(:number),sharename+".d")

  target "Directory #{sharepath}> exist"
  goto :host2, :exec => "cat #{sharepath}"
  expect result.grep!("path").grep!("=").count!.eq(1)

end
