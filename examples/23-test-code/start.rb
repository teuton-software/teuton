group "Test code 1" do
  filepath = "./#{get(:folder)}/#{get(:filename)}"

  target "Sum"
  run "#{filepath} 3 4"
  expect [ "Sum", "7" ]

  target "Mul"
  run "#{filepath} 3 4"
  expect /Mul\s+=\s+12/
end

play do
  show
  export
end
