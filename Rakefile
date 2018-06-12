# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks
namespace :db do
    task :seed => :environment do
        env_seed_file = File.join(Rails.root, "db", "seeds", "#{Rails.env}.rb")
        load(env_seed_file) if File.exist?(env_seed_file)
    end
end