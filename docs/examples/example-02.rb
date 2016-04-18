
=begin
  Test if exist username for every case into localhost:
  * target : Describe the target
  * goto   : Move to localhost and execute the command
  * expect : Check if the result is equal to the expected value
  * get    : Get the value for every case from the configuration YAML file.
=end

task "Create user with your name" do

  target "Checking user <"+get(:username)+"> using commands"
  goto :localhost, :exec => "id #{get(:username)}| wc -l"
  expect result.eq 1

  target "Checking user <"+get(:username)+"> using count! method"
  goto :localhost, :exec => "id #{get(:username)}"
  expect result.count!.eq 1

  target "Checking user <"+get(:username)+"> using find! and count! methods with String arg"
  goto :localhost, :exec => "cat /etc/passwd"
  expect result.find!(get(:username)).count!.eq 1

end

start do
  show
  export
end

