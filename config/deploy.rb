require 'dotenv'
Dotenv.load

# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'geminabox'
set :repo_url, 'git@github.com:hirocaster/geminabox-server.git'

set :bundle_jobs, 4

set :linked_dirs, %w{log data tmp/pids vendor/bundle}

set :rbenv_type, :system
set :rbenv_ruby, File.read('.ruby-version').strip

set :rbenv_path, "/usr/local/rbenv"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby}
set :rbenv_roles, :all # default value

set :puma_nginx, :app
set :puma_bind, %w(tcp://0.0.0.0:9292 unix:///srv/geminabox/shared/tmp/pids/puma.sock)
set :puma_threads, [0, 16]
set :puma_workers, 2
set :puma_worker_timeout, 30

set :bundle_bins, fetch(:bundle_bins).to_a.concat(%w{ puma pumactl })
set :bundle_flags, '--deployment --quiet --path vendor/bundle'
set :rbenv_map_bins, fetch(:rbenv_map_bins).to_a.concat(%w{ puma pumactl })

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/srv/geminabox'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
