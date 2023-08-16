Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  
  root 'static_pages#top'

  get '/terms' => 'static_pages#terms'
  get '/privacy_policy' => 'static_pages#privacy_policy'
  
  resources :rooms, only: %i[index new create show destroy] do
    member do
      get 'enter'
      post 'pass'
      patch 'setting'
    end
    resource :members, only: %i[create destroy], shallow: true
    resources :questions, only: %i[create destroy new show update] do
      resources :answers, only: %i[create]
    end
  end

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
