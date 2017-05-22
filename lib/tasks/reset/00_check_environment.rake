namespace :reset do
  task :check_environment do
    unless %w(development test).include?(Rails.env)
      raise 'Only able to reset environment in develoment or test'
    end
  end
end

task reset: 'reset:check_environment'
