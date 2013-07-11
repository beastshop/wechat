worker_processes 5
working_directory "/var/www/wechat"
preload_app true
timeout 30

pid "/var/www/wechat/tmp/pids/unicorn.pid"
stderr_path "/var/www/wechat/log/unicorn.stderr.log"
stdout_path "/var/www/wechat/log/unicorn.stdout.log"

listen "/var/www/wechat/tmp/unicorn.sock", :backlog => 64
# listen 8080

before_fork do |server, worker|
# This option works in together with preload_app true setting
# What is does is prevent the master process from holding
# the database connection
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
# Here we are establishing the connection after forking worker
# processes
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
