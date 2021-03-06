Blog::Application.routes.draw do

  resources :comments

  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "joined/meetups" => "posts#joinedposts"
  get "hosting/meetups" => "posts#hostedposts"
  get "profile/setting" => "users#edit", :as => "profile_setting"
  post "profile/setting" => "users#update" 

  # get "sessions/new"
  # get "users/new"
  resources :posts
  resources :users
  resources :sessions
  get "posts/new"
  post "posts/index"
  post "posts/search/location/", to: 'posts#searchloc'

  get "posts/show"
  get 'posts/:id', to: 'posts#show'
  get 'joins/:id', to: 'posts#joinedposts'
  post 'join/:id', to: 'joins#create'
  post 'withdraw/:id', to: 'joins#delete'
  post 'comments/', to: 'comments#create'
  post 'conversations/', to: 'conversation#create'
  # get 'conversations/:comment_id', to: 'conversation#show'
  post 'conversations/:comment_id', to: 'conversation#show'
  post 'conversations/approve/:comment_id', to: 'conversation#approve'
  post 'conversations/reject/:comment_id', to: 'conversation#reject'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'posts#index'

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
