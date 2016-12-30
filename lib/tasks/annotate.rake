desc 'Annotate models'
task :annotate do
  sh 'annotate'
end

namespace :db do
  task :migrate do
    Rake::Task['annotate'].invoke
  end
end
