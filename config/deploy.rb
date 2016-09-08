# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'railstutorial'
set :repo_url, 'https://github.com/asuforce/orpheus.git'

set :linked_files, %w{config/database.yml config/secrets.yml}

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets')

namespace :deploy do

  namespace :db do
    desc 'Create database'
    before :migrate, :create do
      on fetch(:migration_servers) do
        within release_path do
          with rails_env: fetch(:rails_env) do
            execute :bundle, :exec, :rake, 'db:create'
          end
        end
      end
    end
  end

  desc 'deploy static files to revproxy instance'
  #task :static_files do
  after :log_revision, :static_files do
    run_locally do
      execute "RAILS_ENV=production bundle exec rake assets:precompile assets:clean"
    end
    on roles(:revproxy) do
      if test "[ -d #{deploy_to}/public ];"
        execute :rm, "-rf", "#{deploy_to}/public"
      end
      upload!('public/', "#{deploy_to}/public", recursive: true)
    end
  end
end
