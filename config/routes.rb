Rails.application.routes.draw do
  devise_for :users
  namespace :site do
    get 'dashboard/index'
  end

  namespace :api do
    get '/forecast', to: 'weather#forecast'
  end

  root 'site/dashboard#index'
end
