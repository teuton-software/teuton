
task 'Opensuse HOSTNAME configurations' do

  target "Checking hostname <" + get(:suse1_hostname) + ">"
  goto  :suse1, :exec => "hostname -f"
  expect result.equal?(get(:suse1_hostname))

  unique "hostname", result.value
  goto  :suse1, :exec => "hostname -f"
  unique "UUID", result.value

end
