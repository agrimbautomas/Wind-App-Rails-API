
set :application, 'wind-api'
set :repo_url, 'git@gitlab.com:wind-app/wind-app.git'

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets',
                                               'vendor/bundle', 'public/system', 'key',
																							 'certificates', 'challenge', 'config/settings')
set :keep_releases, 1
set :rvm_ruby_version, '2.5.1'

namespace :deploy do

  desc 'Restart application'

  desc 'Update Cron Jobs'
  task :update_crontabs do
    on roles(:app), in: :sequence, wait: 5 do
      exec 'whenever --update-crontab'
    end
  end

  after :publishing, :restart

end
