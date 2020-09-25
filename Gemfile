source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'alloy-api', '>= 0.0.7'
gem 'audited', '~> 4.9'
gem 'aws-sdk-s3'
gem 'bcrypt', '~> 3.1.13'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'factory_bot_rails'
gem 'faker'
gem 'haml-rails'
gem 'image_processing', '~> 1.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pg_search', '~> 2.3'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.3'
gem 'redis', '4.1.4' # TEMPORARY
gem 'sass-rails', '>= 6'
gem 'sidekiq'
gem 'thor'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'
gem 'truework', '~> 1.1'
gem 'webmock', '~> 3.9'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'i18n-tasks'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
