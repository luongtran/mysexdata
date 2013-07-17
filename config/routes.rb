Mysexdata::Application.routes.draw do
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :geosexes, only: [:index]
  
  resources :users do
    resources :lovers, only: [:create, :destroy] do
        resources :experiences, only: [:show, :show_all, :create, :update, :destroy]
    end
    resources :friendships, only: [:index, :create, :destroy]
    resources :messages, only: [:index, :create, :destroy]
    resources :photos, only: [:index, :create, :destroy]
    member do
      get :friends, :pendingfriends
    end
  end

  # Login / logout
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  
  # Users
  match '/users', to: 'users#create', via: 'post'                     # Create a user
  match '/users', to: 'users#index', via: 'get'                       # Show all users
  match '/users/:user_id', to: 'users#show', via: 'get'               # Show unique user
  match '/users/:user_id', to: 'users#update', via: 'put'             # Update a user (Default method)
  match '/users/:user_id', to: 'users#destroy', via: 'delete'         # Delete a user (Must be post method).

  # Experiences
  match '/users/:user_id/lovers/:lover_id/experiences', to: 'experiences#show_all', via: 'get'
  match '/users/:user_id/lovers/:lover_id/experiences/:experience_id', to: 'experiences#show', via: 'get'
  match '/users/:user_id/lovers/:lover_id/experiences/:experience_id', to: 'experiences#update', via: 'put'
  match '/users/:user_id/lovers/:lover_id/experiences/:experience_id', to: 'experiences#destroy', via: 'delete'


  # Lovers
  match '/users/:user_id/lovers', to: 'lovers#show_all', via:'get'
  match '/users/:user_id/lovers', to: 'lovers#create', via:'post'
  match '/users/:user_id/lovers/:lover_id', to: 'lovers#show', via:'get'
  match '/users/:user_id/lovers/:lover_id', to: 'lovers#update', via:'put'
  match '/users/:user_id/lovers/:lover_id', to: 'lovers#destroy', via:'delete'

  # Friends lovers
  match '/users/:user_id/friendships/:friendship_id/lovers', to: 'friendships#show_lovers', via: 'get'
  match '/users/:user_id/friendships/:friendship_id/lovers/:lover_id', to: 'friendships#show_lover', via: 'get'

  # Friendships
  match '/users/:user_id/friendships', to: 'friendships#index', via: 'get'
  match '/users/:user_id/friendships', to: 'friendships#create', via: 'post'
  match '/users/:user_id/friendships_secret', to: 'friendships#create_secret', via: 'post'
  match '/users/:user_id/friendships/accept', to: 'friendships#accept', via: 'put'
  match '/users/:user_id/friendships/omit', to: 'friendships#omit', via: 'post'
  match '/users/:user_id/friendships_secret/accept', to: 'friendships#accept_secret', via: 'put'
  match '/users/:user_id/friendships_secret/omit', to: 'friendships#omit', via: 'post'
  match '/users/:user_id/friendships/:friendship_id', to: 'friendships#show', via: 'get'

  # Pending Friends
  match '/users/:user_id/pending_friends', to: 'friendships#pending', via: 'get'

  # Secret Friends
  match '/users/:user_id/secret_friends', to: 'friendships#secrets', via: 'get'

  # Geosex
  match '/users/:user_id/geosex', to: 'geosexes#index', via:'get'


  match '/omitfriendship', to: 'friendships#omit', via: 'post'
  match '/cancelfriendship', to: 'friendships#omit', via: 'post'
  match '/acceptfriendship', to: 'friendships#accept', via: 'put'
  #match '/pendingfriendships', to: 'friendships#pending', via: 'get'
  match '/pendingsecrets', to: 'friendships#secrets', via: 'get'
  match '/pendingsecrets', to: 'friendships#create_secret', via: 'post'
  match '/omitsecrets', to: 'friendships#omit_secret', via: 'put'
  match '/acceptsecret', to: 'friendships#accept_secret', via: 'put'

  # Messages
  match '/clearmessages', to: 'messages#clear', via: 'post'
  
 
  # Photos
 





  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'sessions#new'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
