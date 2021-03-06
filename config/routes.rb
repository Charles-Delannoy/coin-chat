Rails.application.routes.draw do
  get 'chatrooms/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'chatrooms#index'

  get 'login', to: 'users#new'
  post 'login', to: 'users#create'
  delete 'logout', to: 'users#destroy'

  resources :users, only: [:update]

  resources :chatrooms, only: [:index, :create, :show] do
    resources :messages, only: [:create]
  end
end
