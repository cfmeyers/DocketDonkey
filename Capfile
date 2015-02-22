# Load DSL and set up stages
require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/rbenv'

# Include default deployment tasks


set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.2.0-p0'

# require 'capistrano/chruby'
# require 'capistrano/rails/assets'
# require 'capistrano/rails/migrations'
# require 'capistrano/passenger'

# Load custom tasks from `lib/capistrano/tasks' if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
