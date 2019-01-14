
task "Groups and users" do
  shares = []
  shares << { :group => get(:share1_group), :users => get(:share1_users) }
  shares << { :group => get(:share2_group), :users => get(:share2_users) }

  shares.each do |share|
    group = share[:group]
    users = share[:users].split(",")

    users.each do |username|
      target "System User <#{username}> exists"
      goto   :server, :exec => "id #{username}"
      expect result.grep!("uid=").count!.eq(1)

      target "User <#{username}> member of <#{group}>"
      result.restore!
      expect result.grep!(group).count!.eq(1)

      target "Samba User <#{username}> exists"
      goto   :server, :exec => "pdbedit -L"
      expect result.grep!(username).count!.eq(1)
    end
  end
end
