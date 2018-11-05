
task 'Debian HOSTNAME configurations' do
  my_hostname="#{get(:lastname1)}#{get(:number)}d1.#{get(:dominio)}"

  target "Checking hostname <"+my_hostname+">"
  goto  :debian1, :exec => "hostname -f"
  expect result.equal?(my_hostname)

  unique "hostname", result.value
  goto  :debian1, :exec => "blkid |grep sda1"
  unique "UUID", result.value
end
