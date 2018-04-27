workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!
worker_timeout 15

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

before_fork do
  require 'puma_worker_killer'

  # PumaWorkerKiller.config do |config|
  #   config.ram           = 1024 # mb
  #   config.frequency     = 5    # seconds
  #   config.percent_usage = 0.9
  #   config.rolling_restart_frequency = 5 * 3600 # 12 hours in seconds
  #   config.reaper_status_logs = true # setting this to false will not log lines like:
  #   # PumaWorkerKiller: Consuming 54.34765625 mb with master and 2 workers.

  #   config.pre_term = -> (worker) { puts "Worker #{worker.inspect} being killed" }
  # end
  # PumaWorkerKiller.start
  PumaWorkerKiller.enable_rolling_restart
end

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end