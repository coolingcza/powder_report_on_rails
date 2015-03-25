Rails.application.routes.draw do

  resources :resorts, :users, :sessions
  
  root 'misc#log_in'
  get '/powder_report', to: 'misc#log_in', as: 'home'
  
  get '/select_resorts', to: 'misc#select_resorts', as: 'select_resorts'

  post '/set_state', to: 'misc#set_state', as: 'set_state'

  get '/display', to: 'misc#display', as: 'display'
  
  post '/check_sign_in', to: 'misc#check_sign_in', as: 'check_sign_in'
  
  post '/change_resorts', to: 'misc#change_resorts', as: 'change_resorts'
  
  post '/log_out', to: 'sessions#log_out'

  
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
