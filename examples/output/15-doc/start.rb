group "Customize doc output" do
  doc "This is our readme example."
  doc "And here we'll see how to use readme keyword"

  target "Create user david."
  doc "Help: you can use 'useradd' command to create users."
  doc "Remember: Only root is permitted to create new users."

  run "id david"
  expect "david"
end

play do
  show
  export
end
