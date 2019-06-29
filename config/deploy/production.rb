role :app, %w{deploy@api.vientoenelrio.com}
role :web, %w{deploy@api.vientoenelrio.com}
role :db,  %w{deploy@api.vientoenelrio.com}

set :deploy_to, '/srv/rails/wind-api'

server 'api.vientoenelrio.com', user: 'deploy', roles: %w{web app}
set :rails_env, 'production'
set :branch, 'production'