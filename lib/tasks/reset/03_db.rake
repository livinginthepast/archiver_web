desc 'Reset the development environment'
task :reset => %w(
  db:drop:all
  db:create
  db:migrate
)
