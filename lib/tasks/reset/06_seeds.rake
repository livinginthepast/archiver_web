namespace :reset do
  task :seeds do
    Bundler.with_clean_env do
      sh 'source ./.envrc' \
        ' && bundle exec rake db:seed'
    end
  end
end

task reset: 'reset:seeds'
