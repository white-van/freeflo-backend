Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  api_guard_routes for: 'users'

  resources :user do
    get '/projects', to: 'projects#index'
    get '/pull_requests', to: 'pull_requests#index'
    get '/commits', to: 'versions#index'
  end

  scope 'me' do
    scope 'pull_requests' do
      get '/owned', to: 'pull_requests#owned'
      get '/to_review', to: 'pull_requests#to_review'
    end
    scope 'projects' do
      get '/recommended', to: 'projects#recommended'
      get '/owned', to: 'projects#owned'
      get 'unowned_contrib', to: 'projects#unowned_contrib'
    end
  end

  resources :projects do
    resources :versions, path: '/commits', shallow: true
    resources :pull_requests, except: [:destroy, :show, :update]
    resources :branches, shallow: true
    member do
      post '/heart', to: 'projects#heart'
      delete '/heart', to: 'projects#unheart'
    end
  end

  resources :pull_requests, only: [:destroy, :show, :update] do
    member do
      post '/status', to: 'pull_requests#status'
      post '/merge', to: 'pull_requests#merge'
    end
  end

  resources :organizations
end
