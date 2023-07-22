group "Test SQL and database" do
  database = "#{get(:folder)}/#{get(:database)}"
  query = "#{get(:folder)}/#{get(:query)}"

  target "Database schema"
  readme "Create database '#{database}'"
  readme "Create schema 'characters'"
  readme "With '[name varchar, rol varchar]'"
  run "sqlite3 #{database} '.schema characters'"
  expect ["name varchar", "rol varchar"]

  target "Query Jedi"
  readme "Insert '[Obiwan, Jedi]' into 'characters'"
  readme "Create query file '#{query}' that show all rows from 'characters'"
  run "sqlite3 #{database} '.read #{query}'"
  expect ["Obiwan", "Jedi"]
end

play do
  show
  export
end
