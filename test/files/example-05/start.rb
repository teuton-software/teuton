# Test if exist user <obiwan> into localhost
# * target : Describe the target
# * run    : Move to localhost, and execute the command
# * expect : Check if the results are equal to expected value
#
# Teacher host (localhost) must have GNU/Linux OS.

group "Create user obiwan" do
  target "Checking user <obiwan> using commands"
  run "id obiwan| wc -l"
  expect result.equal(1)

  target "Checking user <obiwan> using count! method"
  run "id obiwan"
  expect result.count.eq 1

  target "Checking user <obiwan> using find! and count! methods with String arg"
  run "cat /etc/passwd"
  expect result.find("obiwan").count.eq 1

  target "Checking user <obiwan, obi-wan> using find! and count! methods with Regexp arg"
  run "cat /etc/passwd"
  expect result.find(/obiwan|obi-wan/).count.eq 1
end

play do
  show
  export
end
