# encoding: utf-8

=begin
  Test if exist user <obiwan> into localhost
  * target : Describe the target
  * goto   : Move to localhost, and execute the command
  * expect : Check if the results are equal to expected value
  
  Teacher host (localhost) must have GNU/Linux OS.
=end

task "Create user obiwan" do

  target "Checking user <obiwan> using commands"
  goto :localhost, :exec => "id obiwan| wc -l"
  expect result.equal(1)

  target "Checking user <obiwan> using size! method"
  goto :localhost, :exec => "id obiwan"
  expect result.size!.eq 1

  target "Checking user <obiwan> using grep! and size! methods"
  goto :localhost, :exec => "cat /etc/passwd"
  expect result.grep!("obiwan").size!.eq 1
end

start do
  show
  export
end
