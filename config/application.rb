require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

require File.expand_path('../boot', __FILE__)
ENV['RANSACK_FORM_BUILDER'] = '::SimpleForm::FormBuilder'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Date::DATE_FORMATS.merge!( default: '%d/%m/%Y' )
Time::DATE_FORMATS.merge!( default: '%d/%m/%Y  %T' )
Time::DATE_FORMATS[:custom_date] = "%d/%m/%Y"
Time::DATE_FORMATS[:custom_datetime] = "%d/%m/%Y %T"

module Fabrica
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :options, :put, :delete]
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.time_zone = 'Brasilia'
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.enforce_available_locales = false
    config.i18n.load_path += Dir["#{Rails.root.to_s}/config/locales/**/*.{rb,yml}"]
    config.i18n.default_locale = :'pt-BR'
    config.i18n.available_locales = ["pt-BR"]

    config.active_job.queue_adapter = :sidekiq

    config.cache_store = :memory_store, { size: 64.megabytes }

    config.action_controller.include_all_helpers = true

    if Rails.env.development?
      config.action_mailer.default_url_options = { :host => 'http://127.0.0.1', :port => 3000 }
    else
      config.action_mailer.default_url_options = { :host => 'https://nacionalservicos.com.br' }
    end
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.perform_deliveries = true
    config.action_mailer.delivery_method = :smtp

    config.action_mailer.smtp_settings = {
      :address                => "smtp.nacionalservicos.com.br",
      :port                   => 587,
      :domain                 => 'nacionalservicos.com.br',
      :user_name              => 'sistema@nacionalservicos.com.br',
      :password               => '3rf454y65her',
      :authentication         => 'plain',
      :enable_starttls_auto   => true
    }

    # config.action_mailer.smtp_settings = {
    #   :address              => 'smtp.gmail.com',
    #   :port                 => 587,
    #   :user_name            => 'junior123nelson@gmail.com',
    #   :password             => 'junior@123',
    #   :authentication       => :plain,
    #   :enable_starttls_auto => true
    # }

    config.to_prepare do
      Devise::SessionsController.layout "devise"
      Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "application" : "devise" }
      Devise::ConfirmationsController.layout "devise"
      Devise::UnlocksController.layout "devise"
      Devise::PasswordsController.layout "devise"
    end

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.generators do |g|
      g.test_framework :rspec,
      fixtures: false,
      view_specs: false,
      helper_specs: false,
      routing_specs: false
    end
  end
end
