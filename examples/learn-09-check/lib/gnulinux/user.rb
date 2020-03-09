define_check 'user_exist', :name do
  target "Exist user #{get(:name)}"
  run "id #{get(:name)}"
  expect_one get(:name)
end

define_check 'user_is_member_of', :user, :group do
  target "#{get(:user)} is member of #{get(:group)}"
  run "groups #{get(:user)}"
  expect_one [ get(:user), get(:group) ]
end

define_check 'user_info', :user, :home do
  home = get(:home) || "/home/#{get(:user)}"
  target "#{get(:user)} user with #{home} HOME"
  run "cat /etc/passwd"
  expect_one [ "#{get(:user)}:", ":#{home}:" ]
end
