Rails.application.routes.draw do
  devise_for :users
  namespace :site do
    get 'dashboard/index'
    post 'dashboard/add_to_bookmarks'
    post 'dashboard/remove_from_bookmarks'
  end

  namespace :api do
    get '/forecast', to: 'weather#forecast'
  end

  root 'site/dashboard#index'
end
