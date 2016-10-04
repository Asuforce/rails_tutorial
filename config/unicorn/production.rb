root = File.expand_path('../../../', __FILE__)

worker_processes 2
working_directory root

listen 3000
pid "#{root}/tmp/pids/unicorn.pid"

stderr_path "#{root}/log/unicorn_error.log"
stdout_path "#{root}/log/unicorn.log"
