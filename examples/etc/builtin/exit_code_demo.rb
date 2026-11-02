use "gnulinux/user"

def exit_code(cmd, host = :localhost)
  run cmd, on: host
  run "echo $?", on: host
end

group "Learn about def" do
  exit_code "id vader"
  result.debug
  exit_code "id root"
  result.debug
end

play do
  show
  export
end
