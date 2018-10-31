
task 'Debian HOSTNAME configurations' do
  my_hostname="#{get(:lastname1)}#{get(:number)}d.#{get(:dominio)}"

  target "Checking hostname <"+my_hostname+">"
  goto  :host1, :exec => "hostname -f"
  expect result.equal?(my_hostname)

  unique "hostname", result.value
  goto  :host1, :exec => "blkid |grep sda1"
  unique "UUID", result.value
end
