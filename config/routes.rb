Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  api_guard_routes for: 'users'

  resources :user do
    get '/projects', to: 'projects#index'
    get '/pull_requests', to: 'pull_requests#index'
    get '/commits', to: 'versions#index'
  end

  resources :projects do
    resources :versions, shallow: true
    resources :pull_requests, shallow: true
    member do
      post '/heart', to: 'projects#heart'
      delete '/heart', to: 'projects#unheart'
    end
  end

  resources :organizations
end
