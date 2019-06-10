Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products, only: [:index]
  resources :users, param: :username, only: [:show]

  post 'login', to: 'authentication#authenticate'
  post 'register', to: 'users#create'
end
