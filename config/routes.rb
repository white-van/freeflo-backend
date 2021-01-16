Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  api_guard_routes for: 'users'

  resources :projects do
    resources :versions, shallow: true
    resources :pull_requests, shallow: true
  end

  resources :organizations
end
