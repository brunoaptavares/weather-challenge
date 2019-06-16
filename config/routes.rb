Rails.application.routes.draw do
  namespace :site do

    get 'dashboard/index'
  end

  root 'site/dashboard#index'
end
