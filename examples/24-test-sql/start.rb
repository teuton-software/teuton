group "Test SQL and database" do
  database = "#{get(:folder)}/#{get(:database)}"
  query = "#{get(:folder)}/#{get(:query)}"

  target "Database schema"
  doc "Create database '#{database}'"
  doc "Create schema 'characters'"
  doc "With '[name varchar, rol varchar]'"
  run "sqlite3 #{database} '.schema characters'"
  expect ["name varchar", "rol varchar"]

  target "Query Jedi"
  doc "Insert '[Obiwan, Jedi]' into 'characters'"
  doc "Create query file '#{query}' that show all rows from 'characters'"
  run "sqlite3 #{database} '.read #{query}'"
  expect %w[Obiwan Jedi]
end

play do
  show
  export
end
