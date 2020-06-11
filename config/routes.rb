Rails.application.routes.draw do
  root to: 'applicants#new'
  namespace :admin do
    resources :applicants
  end
  resources :applicants, only: [:new, :create, :show]
end
