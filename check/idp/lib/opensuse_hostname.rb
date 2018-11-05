
task 'Opensuse HOSTNAME configurations' do
  my_hostname="#{get(:lastname1)}#{get(:number)}g.#{get(:dominio)}1"

  target "Checking hostname <"+my_hostname+">"
  goto  :suse1, :exec => "hostname -f"
  expect result.equal?(my_hostname)

  unique "hostname", result.value
  goto  :suse1, :exec => "blkid |grep sda1"
  unique "UUID", result.value
end
