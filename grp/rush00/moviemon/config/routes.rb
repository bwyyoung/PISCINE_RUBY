Rails.application.routes.draw do

  # Pages
  get '/title_screen' => 'game#title_screen', as: :title_screen 
  get '/shutdown' => 'game#shutdown', as: :shutdown
  get '/loading_game' => 'game#loading_game', as: :loading_game
  get '/saving_game' => 'game#saving_game', as: :saving_game
  get '/world_map' => 'game#world_map', as: :world_map
  get '/battle' => 'game#battle', as: :battle
  get '/moviedex' => 'game#moviedex', as: :moviedex
  get '/lose' => 'game#lose', as: :lose
  get '/victory' => 'game#victory', as: :victory
  get '/coward' => 'game#coward', as: :coward

  # Inputs
  get '/power' => 'game#power'
  get '/up' => 'game#up'
  get '/down' => 'game#down'
  get '/right' => 'game#right'
  get '/left' => 'game#left'

  get '/select' => 'game#select'
  get '/start' => 'game#start'
  get '/buttonA' => 'game#buttonA'
  get '/buttonB' => 'game#buttonB'

  root 'game#power'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
