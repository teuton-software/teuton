
group "Using result object" do

  # Capturing hostname value
  run "hostname"
  a = result.value

  target "Ensure exists username #{a}"
  run "id #{a}"
  expect a

  target "Hostname must be #{a}"
  run "hostname"
  expect a

end

group "Checking exit code" do
  users = ['david', 'fran']

  users.each do |user|
    target "Ensure exists username #{a} checking exit code"
    run "id david"
    expect (result.exitstatus == 0)
  end
end

play do
  show
  export
end
