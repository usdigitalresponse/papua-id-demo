Rails.application.routes.draw do
  root to: 'root#index'
  namespace :admin do
    resources :applicants, only: [:index, :show]
  end
  resources :applicants, only: [:new, :create, :show]
  resources :bank_accounts, only: [:new, :create, :show]
end
