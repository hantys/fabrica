if ENV.fetch("RAILS_ENV") == 'development'

  threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
  threads threads_count, threads_count

  port        ENV.fetch("PORT") { 3000 }

  environment ENV.fetch("RAILS_ENV") { "development" }

  plugin :tmp_restart

else
  threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
  threads threads_count, threads_count

  # Specifies the `port` that Puma will listen on to receive requests, default is 3000.
  #
  # port        ENV.fetch("PORT") { 3000 }

  pidfile "/var/www/fabrica/current/tmp/pids/puma.pid"
  stdout_redirect "/var/www/fabrica/shared/log/stdout", "/var/www/fabrica/shared/log/stderr"

  bind "unix:///var/www/fabrica/current/tmp/sockets/puma.sock"

  daemonize true
  threads 0, 4

  preload_app!

  on_worker_boot do
    ActiveSupport.on_load(:active_record) do
      ActiveRecord::Base.establish_connection
    end
  end

  before_fork do
    ActiveRecord::Base.connection_pool.disconnect!
  end

end

# workers Integer(ENV['WEB_CONCURRENCY'] || 2)
# threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
# threads threads_count, threads_count

# preload_app!
# worker_timeout 15

# rackup      DefaultRackup
# port        ENV['PORT']     || 3000
# environment ENV['RACK_ENV'] || 'development'

# before_fork do
#   require 'puma_worker_killer'

#   # PumaWorkerKiller.config do |config|
#   #   config.ram           = 1024 # mb
#   #   config.frequency     = 5    # seconds
#   #   config.percent_usage = 0.9
#   #   config.rolling_restart_frequency = 5 * 3600 # 12 hours in seconds
#   #   config.reaper_status_logs = true # setting this to false will not log lines like:
#   #   # PumaWorkerKiller: Consuming 54.34765625 mb with master and 2 workers.

#   #   config.pre_term = -> (worker) { puts "Worker #{worker.inspect} being killed" }
#   # end
#   # PumaWorkerKiller.start
#   PumaWorkerKiller.enable_rolling_restart
# end

# on_worker_boot do
#   # Worker specific setup for Rails 4.1+
#   # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
#   ActiveRecord::Base.establish_connection
# end