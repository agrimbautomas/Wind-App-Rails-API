role :app, %w{deploy@wind-api.amalgama.co}
role :web, %w{deploy@wind-api.amalgama.co}
role :db,  %w{deploy@wind-api.amalgama.co}

set :deploy_to, '/srv/rails/wind-api'

server 'wind-api.amalgama.co', user: 'deploy', roles: %w{web app}
set :rails_env, 'production'
set :branch, 'production'