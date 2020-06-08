Rails.application.routes.draw do
  root to: 'applicants#new'
  resources :applicants, only: [:new, :create, :show]
end
