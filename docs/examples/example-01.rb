
=begin
  Test if exist user <obiwan> into localhost using several ways
  * target : Describe the target
  * goto   : Move to localhost, and execute the command
  * expect : Check if the results are equal to expected value

  Teacher host (localhost) must have GNU/Linux OS.
=end

task "Create user obiwan using several ways" do

  target "Way 1: Checking user <obiwan> using commands"
  goto :localhost, :exec => "id obiwan| wc -l"
  expect result.equal(1)

  target "Way 2: Checking user <obiwan> using count! method"
  goto :localhost, :exec => "id obiwan"
  expect result.count!.eq 1

  target "Way 3: Checking user <obiwan> using find! and count! methods with String arg"
  goto :localhost, :exec => "cat /etc/passwd"
  expect result.find!("obiwan").count!.eq 1

  target "Way 4: Checking user <obiwan, obi-wan> using find! and count! methods with Regexp arg"
  goto :localhost, :exec => "cat /etc/passwd"
  expect result.find!(/obiwan|obi-wan/).count!.eq 1
end

start do
  show
  export
end
