Rails.application.routes.draw do
  namespace :site do
    get 'dashboard/index'
  end

  namespace :api do
    get '/forecast', to: 'weather#forecast'
  end

  root 'site/dashboard#index'
end
