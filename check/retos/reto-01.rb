# encoding: utf-8

=begin
 Name        : target 01
 Author      : David Vargas Ruiz
 Description : Create user with your name
=end


task "Target 01" do

  target "Create user <"+get(:username)+">"
  goto :localhost, :exec => "id #{get(:username)}"
  expect result.count!.equal?(1)

end

start do
	show
	export
end

=begin
---
:global:
  :username: david
:cases:
=end
