group "Customize readme output" do
  readme "This is our readme example."
  readme "And here we'll see how to use readme keyword"

  target "Create user david."
  readme "Help: you can use 'useradd' command to create users."
  readme "Remember: Only root is permitted to create new users."

  run "id david"
  expect "david"
end

play do
  show
  export
end
