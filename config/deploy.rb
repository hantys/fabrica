require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
require 'mina/puma'
require 'mina/sitemap_generator'
require 'mina_sidekiq/tasks'
require 'mina/multi_server'


set :application, 'fabrica'

# set :servers, ['34.205.119.35'] #jobs
set :servers, ['162.243.169.133']

set :user, "deploy"
# set :identity_file, '/home/pedro/.ssh/AdminRuafabrica.pem'

# set :domain, '34.234.164.212' #homologacao
# set :user, "centos"
# set :identity_file, '~/.ssh/CavernaKey.pem'

set :deploy_to, "/var/www/fabrica"
set :repository, 'git@github.com:hantys/fabrica.git'

set :branch, 'master'

set :forward_agent, true

set :shared_dirs, fetch(:shared_dirs, []).push('log', 'tmp', 'public/uploads', 'public/assets', 'public/sitemaps', 'public/sitemaps_images')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/application.yml', 'config/secrets.yml')

set :rvm_use_path, '/usr/local/rvm/scripts/rvm'
set :sidekiq_pid, "#{fetch(:shared_path)}/tmp/pids/sidekiq.pid"
set :keep_releases, 10

set :force_asset_precompile, true

task :environment do
  # invoke :'rvm:use[ruby-2.3.3@default]'
  invoke :'rvm:use', 'ruby-2.5.1@default'
end

task :setup do
  command %[mkdir -p "/#{fetch(:shared_path)}/log"]
  command %[chmod g+rx,u+rwx "/#{fetch(:shared_path)}/log"]

  command %[mkdir -p "/#{fetch(:shared_path)}/tmp/pids"]
  command %[chmod g+rx,u+rwx "/#{fetch(:shared_path)}/tmp/pids"]

  command %[mkdir -p "/#{fetch(:shared_path)}/tmp/sockets"]
  command %[chmod g+rx,u+rwx "/#{fetch(:shared_path)}/tmp/sockets"]

  command %[mkdir -p "/#{fetch(:shared_path)}/config"]
  command %[chmod g+rx,u+rwx "/#{fetch(:shared_path)}/config"]

  command %[mkdir -p "/#{fetch(:shared_path)}/public/uploads"]
  command %[chmod g+rx,u+rwx "/#{fetch(:shared_path)}/public/uploads"]

  command %[mkdir -p "/#{fetch(:shared_path)}/public/assets"]
  command %[chmod g+rx,u+rwx "/#{fetch(:shared_path)}/public/assets"]

  command %[touch "/#{fetch(:shared_path)}/config/application.yml"]
  command %[touch "/#{fetch(:shared_path)}/config/database.yml"]
  command %[touch "/#{fetch(:shared_path)}/config/secrets.yml"]

end


desc "Deploys the current version to the server."
task :deploy do
  on :before_hook do
    # Put things to run locally before ssh
  end
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    # invoke :'sidekiq:quiet'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      invoke :'puma:hard_restart'
      # invoke :'sitemap:refresh'
    end
  end
end
