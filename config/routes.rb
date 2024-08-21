# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

#sidekiq web
require 'sidekiq/web'
Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'pages#home'
  get 'pages/about'
  
  # Weather Report
  resources :weather_reports, param: :city_id, only: [:index, :show, :create, :destroy]

  # devise paths
  devise_for :users
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  #sidekiq
  mount Sidekiq::Web => '/sidekiq'
end
