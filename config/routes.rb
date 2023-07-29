Rails.application.routes.draw do
  root 'rooms#show'

  get '/terms' => 'static_pages#terms'
  get '/privacy_policy' => 'static_pages#privacy_policy'
  
  devise_for :users
  get 'rooms/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
