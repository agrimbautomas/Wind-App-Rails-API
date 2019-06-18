role :app, %w{deploy@wind.amalgama.co}
role :web, %w{deploy@wind.amalgama.co}
role :db,  %w{deploy@wind.amalgama.co}

set :deploy_to, '/srv/rails/wind-app'

server 'wind.amalgama.co', user: 'deploy', roles: %w{web app}
set :rails_env, 'production'
set :branch, 'production'