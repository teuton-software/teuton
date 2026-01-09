namespace :test do
  Rake::TestTask.new(:fast) do |t|
    t.description = "Run fast tests (excluding slow tests)"
    t.libs << "test"
    t.test_files = FileList["test/**/*_test.rb"].exclude(/slow_|test_slow/)
  end

  Rake::TestTask.new(:all) do |t|
    t.description = "Run all tests (including slow tests)"
    t.libs << "test"
    t.test_files = FileList["test/**/*_test.rb"]
  end
end
