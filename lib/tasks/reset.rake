desc 'Reset the development environment'
task :reset => %w(
  reset:check_environment
  reset:bower
  reset:lapine
  db:drop:all
  db:create
  db:migrate
  db:seed
  annotate
)
