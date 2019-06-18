Rails.application.routes.draw do

  devise_for :users
  root to: 'home#index'
	
  #get 'sample', to: 'wind-app#sample'

end
