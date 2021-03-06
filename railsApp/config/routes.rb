Rails.application.routes.draw do
  resources :endorsements, except: [:new, :edit]
  resources :chats, except: [:new, :edit]
  resources :reviews, except: [:new, :edit]
  resources :rooms, except: [:new, :edit]
  resources :users, except: [:new, :edit, :update]

  resource :current_user, only: [:show, :update] do
    post '/watsonfeed', to: 'current_users#watsonfeed'
    put '/room', to: 'current_users#putroom'
    get '/room', to: 'current_users#getroom'
    post '/roomdelete', to: 'current_users#destroyroom'
  end

  # get '/viewimage', to: 'rooms#viewimage'
  # get '/upload', to: 'rooms#upload'
  post '/uploadImage', to: 'rooms#uploadImage'

  get '/watson/:id', to: 'watson#show'
  post '/authenticate', to: 'auth#login'
  get '/authtest', to: 'auth#test'
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
