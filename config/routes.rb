Rails.application.routes.draw do
  use_doorkeeper
  root 'static#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :posts
  get 'posts/user/:id', to: 'posts#index', as: :user_posts

  get 'comments/show/:id', to: 'posts#show_comments', as: :comments
  # get 'comments/new', to: 'posts#throw_comment', as: :new_comment
  post 'comments/create/', to: 'posts#create_comment', as: :create_comment

  get '/contact', to: 'static#support', as: :contact_mailer
  get '/share/:id', to: 'static#share', as: :share_blog

  get '/archived_posts/user/:id', to: 'archived_posts#index', as: :archived_posts
  get '/archived_posts/:id', to: 'archived_posts#show', as: :archived_post
  post '/archived_posts/:id/archive', to: 'archived_posts#archive', as: :create_archived_posts
  post '/archived_posts/:id/unarchive', to: 'archived_posts#unarchive', as: :unarchive_archived_post
  delete '/archived_post/:id', to: 'archived_posts#destroy', as: :remove_archived_post
  get 'comments/:id/show', to: 'archived_posts#show_comments', as: :archived_comments

  namespace :api do
      # Directs /admin/products/* to Admin::ProductsController
      # (app/controllers/admin/products_controller.rb)
      get '/posts/user/:id', to: 'posts_api#index'

      get '/users', to: 'users#index'
      get '/user/:id', to: 'users#show'
    end
  # get 'comments/destroy', to: 'posts#destroy_comment', as: :delete_comment

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
