source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'enum_help'
gem 'cancancan', '~> 2.0'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'jquery-rails'
gem 'puma_worker_killer'

gem 'pry-rails'
gem 'pry-meta'
gem 'devise'
gem 'simple_form'
gem 'nested_form'
gem 'ransack'
gem 'faker'
gem 'ffaker'
#auditorias
gem 'paper_trail' # https://github.com/paper-trail-gem/paper_trail
gem 'paper_trail-association_tracking'
#fim
#deleta fake
gem "paranoia", "~> 2.2" # https://github.com/rubysherpas/paranoia
#fim
gem "correios_api", github: "hantys/correios_api"#, branch: 'update_rails'

#paginacao
gem 'kaminari'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.6'
  gem 'capybara'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'httparty'
  gem 'webmock'
  gem 'vcr'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'rspec-json_expectations'
  gem 'json_matchers'
end

group :development do
  # gem 'web-console' #https://github.com/rails/web-console#usage
  gem 'better_errors' #https://github.com/charliesome/better_errors/wiki/Link-to-your-editor

  gem 'mina'
  gem 'mina-puma'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "slack-notifier"

  gem 'bullet' # https://github.com/flyerhzm/bullet
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
end

group :production do
  gem 'rails_12factor'
end
