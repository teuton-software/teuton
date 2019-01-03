
task 'GNU/Linux HOSTNAME configurations' do

  target "Checking hostname <" + get(:linux1_hostname) + ">"
  goto  :linux1, :exec => "hostname -f"
  expect result.equal?(get(:linux1_hostname))

  unique "hostname", result.value
  goto  :linux1, :exec => "hostname -f"
  unique "UUID", result.value

end
