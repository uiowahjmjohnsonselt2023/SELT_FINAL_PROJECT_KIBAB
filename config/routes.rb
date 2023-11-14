Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
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
  get '/auth/:provider/callback', to: 'sessions#omniauth'
  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  # root :to => redirect('/')
  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
