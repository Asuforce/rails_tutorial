root = File.expand_path('../../', __FILE__)

worker_processes 2
working_directory root

listen "#{root}/tmp/unicorn.sock"
pid "#{root}/tmp/unicorn.pid"

stderr_path "#{root}/log/unicorn_error.log"
stdout_path "#{root}/log/unicorn.log"
