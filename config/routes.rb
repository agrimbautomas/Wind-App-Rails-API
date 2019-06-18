Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'admin/entries#index'
  get 'scrape', to: 'wind-app#scrape'
  #get 'sample', to: 'wind-app#sample'

end
