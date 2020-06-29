require 'sidekiq/web'
require 'admin_constraint'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq', :constraints => AdminConstraint.new
  root to: 'root#index'
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin, constraints: AdminConstraint.new do
    resources :applicants, only: [:index, :show]
    resources :documents, only: [:show]
  end
  resources :applicants, only: [:new, :create, :show] do
    resources :documents, only: [:new, :create]
  end
  resources :bank_accounts, only: [:new, :create, :show]
end
