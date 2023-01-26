group "Learning about log messages" do
  log "Using log messages."

  target "Create user david"
  run "id david"
  log result.value
  expect "david"

  log "Problem detected!", :error
  log "This is a warning", :warn
  log "Hi, there!", :info
end

play do
  show
  export
end
