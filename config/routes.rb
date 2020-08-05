require 'sidekiq/web'
require 'admin_constraint'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' #, :constraints => AdminConstraint.new
  root to: 'admin/applicants#index'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/login', to: 'sessions#new', as: 'login'
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do #, constraints: AdminConstraint.new do
    resources :applicants, only: [:index, :show] do
      member do
        get :show2
      end
    end
    resources :documents, only: [:show]
    resources :metrics, only: [:index]
  end
  resources :applicants, only: [:new, :create, :show] do
    resources :documents, only: [:new, :create]
    resources :bank_accounts, only: [:new, :create]
    resources :wage_verifications, only: [:new, :create]
  end
  get '*path', to: 'sessions#new', :constraints => LoginConstraint.new
end
