Rails.application.routes.draw do

	devise_for :admin_users, ActiveAdmin::Devise.config
	ActiveAdmin.routes(self)

	devise_for :users

	root to: 'admin/wind_avgs#index'


	scope module: 'api' do
		scope '1', module: 'v1' do

			get 'stats', to: 'stats#index'
		end
	end


end
