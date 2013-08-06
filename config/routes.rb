Mysexdata::Application.routes.draw do

  #Active admin configuration
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  #Apipie route configuration.
  apipie

  resources :sessions, only: [:new, :create, :destroy]



  # Login / logout
  match '/signin',  to: 'sessions#new',         via: 'get'

  # Users
  match '/users', to: 'users#create', via: 'post'                # Create a user
  match '/users', to: 'users#index', via: 'get'                  # Show all users
  match '/users/:user_id', to: 'users#show', via: 'get'               # Show unique user
  match '/users/:user_id', to: 'users#update', via: 'put'             # Update a user (Default method)
  match '/users/:user_id', to: 'users#destroy', via: 'delete'         # Delete a user (Must be post method).

  #Sex affinity
  match '/users/:user_id/sex_affinity/:user2_id', to: 'users#sex_affinity', via: 'get'

  #Report abuse
  match '/users/:user_id/report_abuse', to: 'users#report_abuse', via: 'post'


  # Experiences
  match '/users/:user_id/lovers/:lover_id/experiences', to: 'experiences#index', via: 'get'
  match '/users/:user_id/lovers/:lover_id/experiences', to: 'experiences#create', via: 'post'
  match '/users/:user_id/lovers/:lover_id/experiences/:experience_id', to: 'experiences#show', via: 'get'
  match '/users/:user_id/lovers/:lover_id/experiences/:experience_id', to: 'experiences#update', via: 'put'
  match '/users/:user_id/lovers/:lover_id/experiences/:experience_id', to: 'experiences#destroy', via: 'delete'


  # Lovers
  match '/users/:user_id/lovers', to: 'lovers#index', via:'get'
  match '/users/:user_id/lovers', to: 'lovers#create', via:'post'
  match '/users/:user_id/lovers/:lover_id', to: 'lovers#show', via:'get'
  match '/users/:user_id/lovers/:lover_id', to: 'lovers#update', via:'put'
  match '/users/:user_id/lovers/:lover_id', to: 'lovers#destroy', via:'delete'

  # Friendships
  match '/users/:user_id/friendships', to: 'friendships#index', via: 'get'
  match '/users/:user_id/friendships', to: 'friendships#create', via: 'post'
  match '/users/:user_id/friendships_mail', to: 'friendships#create_mail', via: 'post'
  match '/users/:user_id/friendships_facebook', to: 'friendships#create_facebook', via: 'post'
  match '/users/:user_id/friendships_secret', to: 'friendships#create_secret', via: 'post'
  match '/users/:user_id/friendships/accept', to: 'friendships#accept', via: 'put'
  match '/users/:user_id/friendships/omit', to: 'friendships#omit', via: 'post'
  match '/users/:user_id/friendships_secret/accept', to: 'friendships#accept_secret', via: 'put'
  match '/users/:user_id/friendships_secret/omit', to: 'friendships#omit_secret', via: 'post'
  match '/users/:user_id/friendships/:friend_id', to: 'friendships#show', via: 'get'
  match '/users/:user_id/friendships_pending', to: 'friendships#pending', via: 'get'
  match '/users/:user_id/friendships_secret_pending', to: 'friendships#secrets', via: 'get'
  match '/users/:user_id/friendships/:friend_id/lovers', to: 'friendships#get_friend_lovers', via: 'get'
  match '/users/:user_id/friendships/:friend_id/lovers/:lover_id', to: 'friendships#get_friend_lover', via: 'get'
  match '/users/:user_id/friendships/:friend_id/lovers/:lover_id/experiences/:experience_id', to: 'friendships#lover_experience', via: 'get'

  # Geosex
  match '/users/:user_id/geosex', to: 'geosexes#index', via:'get'
  match '/users/:user_id/geosex', to: 'geosexes#create', via:'post'
  match '/users/:user_id/geosex', to: 'geosexes#locate', via:'put'
  match '/users/:user_id/closest_users', to: 'geosexes#search_closest_users', via:'get'

  # Messages
  match '/users/:user_id/messages', to: 'messages#index', via: 'get'
  match '/users/:user_id/messages', to: 'messages#create', via: 'post'
  match '/users/:user_id/messages', to: 'messages#clear', via: 'delete'


  # Photos
  match '/users/:user_id/photos', to: 'photos#index', via: 'get'
  match '/users/:user_id/photos', to: 'photos#create', via: 'post'
  match '/users/:user_id/photos/:photo_id', to: 'photos#show', via: 'get'
  match '/users/:user_id/photos/:photo_id', to: 'photos#destroy', via: 'delete'






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
