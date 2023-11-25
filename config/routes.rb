Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  match '/products/search',to: 'products#search', via: :get, :as => 'search_path'
  resources :products
  resources :sessions, only: [:new, :create, :destroy]
  root :to => redirect('/products')
  resources :users

  match '/about', to: 'products#about', via: :get, :as => 'about_path'
  match '/products/:id/transaction', to: 'products#transaction', via: :get, :as => 'transaction_path'
  match '/login',  to: 'sessions#new', via: :get, :as => 'login_path'
  match '/logout', to: 'sessions#destroy', via: :delete, :as => 'logout_path'
  match '/history/purchase', to: 'users#purchase', via: :get, :as => 'purchase_history_path'
  match '/history/seller', to: 'users#seller', via: :get, :as => 'seller_history_path'
  get '/auth/:provider/callback', to: 'sessions#create'
  post 'products/add_shopping_cart'
  match '/products/add_shopping_cart', to: 'products#add_shopping_cart', via: :post, :as => 'shopping_cart'
  match '/shopping_cart/index', to: 'shopping_cart#index', via: :get, :as => 'view_shopping_cart'
  match '/shopping_cart/checkout', to: 'shopping_cart#checkout', via: :post, :as => 'checkout'
  match '/shopping_cart/checkout/confirm_purchase', to: 'shopping_cart#confirm_purchase', via: :post, :as => 'confirm_purchase'


  resources :shopping_cart
  # Defines the root path route ("/")
  # root "posts#index"
end
