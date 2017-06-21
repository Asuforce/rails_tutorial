# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

# execute "bundle install"
require 'capistrano/bundler'

require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'

# execute start-up unicorn from capistrano
# require 'capistrano3/unicorn'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
