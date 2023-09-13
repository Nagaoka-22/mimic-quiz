Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  
  root 'static_pages#top'

  get '/terms' => 'static_pages#terms'
  get '/privacy_policy' => 'static_pages#privacy_policy'
  post '/search' => 'rooms#search'
  
  resources :rooms, only: %i[index new create show destroy] do
    member do
      get 'enter'
      post 'pass'
      patch 'setting'
      patch 'finish'
      get 'result'
    end
    resource :members, only: %i[create destroy], shallow: true
    resources :questions, only: %i[create destroy new show] do
      resources :answers, only: %i[create]
      resources :votes, only: %i[create]
      member do
        patch 'ask'
        patch 'vote'
        patch 'result'
        patch 'end'
      end
    end
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
end
