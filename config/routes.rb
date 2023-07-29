Rails.application.routes.draw do
  root 'rooms#show'

  devise_for :users
  get 'rooms/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
