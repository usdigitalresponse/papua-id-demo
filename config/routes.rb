require 'sidekiq/web'
require 'admin_constraint'

Rails.application.routes.draw do
  get 'dashboard/index'
  mount Sidekiq::Web => '/sidekiq' #, :constraints => AdminConstraint.new
  root to: 'admin/dashboard#index'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/login', to: 'sessions#new', as: 'login'
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do #, constraints: AdminConstraint.new do
    get 'dashboard', to: 'dashboard#index', as: 'dashboard'
    resources :applicants, only: [:index, :show, :update] do
      member do
        get :show2
      end
      resources :truework_income_verifications, only: [:new, :create, :show, :index]
      resources :alloy_identity_verifications, only: [:create]
    end
    resources :documents, only: [:show]
    resources :metrics, only: [:index]
  end
  resources :alloy_identity_validations, only: [:show], module: :admin # this has to be outside of the namespace to trigger the proper calls when linking directly to an object
  resources :applicants, only: [:new, :create, :show] do
    resources :documents, only: [:new, :create]
    resources :bank_accounts, only: [:new, :create]
  end
  get '*path', to: 'sessions#new', :constraints => LoginConstraint.new
end
