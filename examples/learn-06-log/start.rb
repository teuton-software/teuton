
group "learn-01-target" do
  log 'Using log messages...'

  target "Create user <david>"
  run "id david"
  expect "david"

  log 'Problem detected!', :error
end

play do
  show
  export
end
