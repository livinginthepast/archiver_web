source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.x'

gem 'aws-sdk'
gem 'dalli'
gem 'inline_svg'
gem 'kaminari'
gem 'lapine'
gem 'omniauth-google-oauth2'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'rails_middleware_delegator'
gem 'sass-rails', github: 'rails/sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'virtus'

gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'webpacker', github: 'rails/webpacker'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'pry-nav'
  gem 'rb-readline'
end

group :development do
  gem 'annotate'
  gem 'foreman'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'factory_girl'
  gem 'faker'
  gem 'guard-rspec'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

