Rails.application.routes.draw do
  root 'players#new_game'
  # for URL localhost:3000/ or localhost:3000/new_game
  get 'new_game' => 'players#new_game'
  # path for form_tag on the new_game page; this path was dictated by the game at tealeaf
  post 'new_game' => 'players#new_game'
  # redirect_to here by the new_game action; or link_to here by the "Yes" link on the play page
  get 'bet' => 'players#bet'
  # path for form_tag on the bet page; this path was dictated by the game at tealeaf
  post 'bet' => 'players#bet'
  # redirect_to here by the bet action
  get 'play' => 'players#play'
  # path for the Stay form_tag on the play page
  post 'hit' => 'players#hit'
  # path for the "Stay" form_tag on the play page
  post 'stay' => 'players#stay'
  # path for the "Next" form_tag on the play page
  post 'next' => 'players#next'
  # link_to here by the "No" link on the play page
  get 'game_over' => 'players#game_over'

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
