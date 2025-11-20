namespace :test do
  desc "Run tests (excluding slow tests)"
  Rake::TestTask.new(:fast) do |t|
    t.libs << "test"
    t.test_files = FileList["test/**/*_test.rb"].exclude(/slow_|test_slow/)
  end

  Rake::TestTask.new(:all) do |t|
    t.libs << "test"
    t.test_files = FileList["test/**/*_test.rb"]
  end
end
