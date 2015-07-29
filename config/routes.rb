Rails.application.routes.draw do
  # when we’re adding collection, we are 
  # making the ‘cards/expired’ path available 
  # and then the cards controller knows to take 
  # that action and what to do with it because we 
  # have the expired method in the cards controller
  resources :cards do
    collection do
      get 'expired'
    end
  end

  post '/share-card' => 'user_card#create', as: 'share_card'
  
  # this nesting is done here so that we can have 
  # the types of routes such as "user_cards_path" in 
  # app/views/users/index.html.erb
  resources :users do
    resources :cards
  end

  resources :sessions

  root 'users#index'

  # this relates to the logout link in application.html.erb
  delete '/logout' => 'sessions#destroy', as: 'logout'
  
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
