# encoding: utf-8

task 'hostname_configurations' do
  my_hostname="ssh-server#{get(:number)}g.#{get(:dominio)}"

  target "Checking hostname <"+my_hostname+">"
  goto  :host1, :exec => "hostname -f"
  expect result.equal?(my_hostname)

end
