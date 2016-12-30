source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'

gem 'aws-sdk'
gem 'dalli'
gem 'kaminari'
gem 'lapine'
gem 'nokogiri', '~> 1.6.8.1'
gem 'omniauth-google-oauth2'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'rails_middleware_delegator'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'virtus'

gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

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

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
