Rails.application.routes.draw do
  root to: 'root#index'
  namespace :admin do
    resources :applicants
  end
  resources :applicants, only: [:new, :create, :show]
end
