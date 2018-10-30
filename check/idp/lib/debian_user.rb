# encoding: utf-8

task 'user_definitions' do
  username=get(:firstname)

  target "User <#{username}> exists"
  goto  :host1, :exec => "cat /etc/passwd"
  expect result.find!(username).count!.eq(1)

  target "Users <#{username}> with not empty password "
  goto  :host1, :exec => "cat /etc/shadow | grep '#{username}:' | cut -d : -f 2"
  expect result.count!.eq(1)

  target "User <#{username}> logged"
  goto  :host1, :exec => "last | grep #{username[0,8]} | wc -l"
  expect result.neq(0)
end
