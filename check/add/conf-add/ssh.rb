# encoding: utf-8

task 'hostname_configurations' do

  my_hostname="ssh-server#{get(:number)}"
  target "Checking hostname <"+my_hostname+">"
  goto  :host1, :exec => "hostname"
  expect result.equal?(my_hostname)

end
