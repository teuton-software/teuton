
task "Client1: puppet actions" do
  username = 'barbaroja'
  target "User <#{username}>"
  goto :client1, :exec => "id #{username}"
  expect result.count!.eq(1)
end
