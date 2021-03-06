Zollaria::Application.routes.draw do
  get "users/home"

  get "users/buy"

  get "users/search"

  get "shop/buy"

  get "search_controller/search_result"

  get "open/search_result"

  get "open/close"
  
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  match '/home', to: 'users#home'
  match '/search', to: 'users#search'
  match '/like', to: 'users#like'
  match '/unlike', to: 'users#unlike'
  match '/home_ajax', to: 'users#home_ajax'
  match '/friends_main', to: 'users#friends_main'
  match '/view_friend_profile', to: 'users#view_friend_profile'
  match '/shop', to: 'users#shop'
  match '/users/search', to: 'users#search'
  match '/buy_check', to: 'users#buy_check'
  match '/buy_confirm', to: 'users#buy_confirm'
  match '/buy', to: 'users#buy'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'home#index'
  root to: redirect('/auth/facebook/')
  
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
