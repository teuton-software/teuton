
task "MV configuration" do

  target "Hostname <#{get(:hostname)}>"
  goto :host1, :exec => "hostname -a"
  expect result.equal(get(:hostname))

  target "Domainname <#{get(:domain)}>"
  goto :host1, :exec => "hostname -d"
  expect result.equal(get(:domain)), :weight => 2.0

end

task "Checking Starwars Characters" do

  target "Exists user <#{get(:username)}>"
  goto :host1, :exec => "id #{ get(:username) }"
  expect result.count!.equal(1)

  result.restore!

  target "User <#{ get(:username) }> is member of <#{ get(:groupname) }>"
  expect result.grep!( "("+get(:groupname)+")" ).count!.equal(1)

end

task "Checking Starwars Directories" do

  target "Directory <friends>"
  goto :host1, :exec => "vdir #{ "/home/"+get(:username) }"
  expect result.grep!(/^drwxrwx---/).grep!( get(:groupname) ).grep!("friends").count!.equal(1)

  result.restore!
  
  target "Directory <starwars>"
  expect result.grep!(/^drwxrwxrwx/).grep!( "users" ).grep!(/starwars/).count!.equal(1)

end

start do
  show
  export :format => :colored_text
  send :copy_to => :host1
end
