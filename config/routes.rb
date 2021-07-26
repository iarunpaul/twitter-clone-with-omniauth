Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks' }
  root to: 'tweeets#index'
  namespace :api do
    scope module: :v1, constraints: ApiConstraints.new(version: 1), defaults: {format: 'json'} do
      resources :tweeets
    end
    scope module: :v2, constraints: ApiConstraints.new(version: 2, default: true) do
      resources :tweeets
    end
  end
  resources :tweeets
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
