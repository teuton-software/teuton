
group "learn-07-readme" do
  readme "This is our example 07."
  readme "And here we'll see how to use readme keyword"

  target "Create user david."
  readme "Help: you can use 'useradd' command to create users."
  readme "Remember: Only root creates new users."
  run "id david"
  expect "david"
end

play do
  show
  export
end
