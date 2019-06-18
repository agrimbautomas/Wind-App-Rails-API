role :app, %w{deploy@174.129.91.31}
role :web, %w{deploy@174.129.91.31}
role :db,  %w{deploy@174.129.91.31}

set :deploy_to, '/srv/rails/wind-app'

server '174.129.91.31', user: 'deploy', roles: %w{web app}
set :rails_env, 'production'
set :branch, 'production'