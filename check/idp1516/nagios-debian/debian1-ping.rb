# encoding: utf-8

task "Ping from debian1 to *" do  
   
  target "ping debian1 to debian2_ip"
  goto :debian1, :exec => "ping #{get(:debian2_ip)} -c 1"
  expect result.grep!("64 bytes from").count!.eq 1

  target "ping debian1 to debian2_name"
  goto :debian1, :exec => "ping #{@short_hostname[2]} -c 1"
  expect result.grep!("64 bytes from").count!.eq 1

  target "ping debian1 to windows1_ip"
  goto :debian1, :exec => "ping #{get(:windows1_ip)} -c 1"
  expect result.grep!("64 bytes from").count!.eq 1

  target "ping debian1 to windows1_name"
  goto :debian1, :exec => "ping #{@short_hostname[3]} -c 1"
  expect result.grep!("64 bytes from").count!.eq 1

end

