
task 'Debian HOSTNAME configurations' do

  target "Checking hostname <" + get(:debian1_hostname) + ">"
  goto  :debian1, :exec => "hostname -f"
  expect result.equal?(get(:debian1_hostname))

  unique "hostname", result.value
  goto  :debian1, :exec => "hostname -f"
  unique "UUID", result.value
end
