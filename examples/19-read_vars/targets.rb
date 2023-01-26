group "Ways to read config vars" do
  # "get(:dirname)"" reads dirname var from config file
  target "Exist #{get(:dirname)} directory"
  run "file #{get(:dirname)}"
  expect_none "No such file or directory"

  # "_dirname" is equivalet to "get(:dirname)"
  target "Exist #{_dirname} directory"
  run "file #{_dirname}"
  expect_none "No such file or directory"

  # "dirname" is a variable
  dirname = get(:dirname)
  target "Exist #{dirname} directory"
  run "file #{dirname}"
  expect_none "No such file or directory"
end
