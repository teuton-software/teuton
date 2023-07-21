group "Test code example" do
  filepath = "./#{get(:folder)}/#{get(:filename)}"

  target "Script calculates the sum of 2 numbers"
  run "#{filepath} 3 4"
  expect ["Sum", "7"]

  target "Script calculates the multiplication of 2 numbers"
  run "#{filepath} 3 4"
  expect(/Mul\s+=\s+12/)
end

play do
  show
  export
end
