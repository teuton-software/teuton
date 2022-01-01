
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

play do
  show
  export
end
