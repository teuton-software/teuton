
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

  target "Checking user <obiwan> using count! method"
  goto :localhost, :exec => "id obiwan"
  expect result.count!.eq 1

  target "Checking user <obiwan, obi-wan> using find! and count! methods with String arg"
  goto :localhost, :exec => "cat /etc/passwd"
  expect result.find!("obiwan").count!.eq 1

  target "Checking user <obiwan> using find! and count! methods with Regexp arg"
  goto :localhost, :exec => "cat /etc/passwd"
  expect result.find!(/obiwan|obi-wan/).count!.eq 1
end

start do
  show
  export 
end
