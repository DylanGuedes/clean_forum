Rails.application.routes.draw do
  root 'forum#index'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :posts
  resources :topics
  resources :sections
  resources :reports

  get '/report_topics/' => 'posts#new'
  #posts controller
  get '/sections/topics/:id/new' => 'posts#new'
  get '/sections/topics/posts/:id' => 'posts#show'
  get '/report_topic/:id' => 'topics#render_report'
  get '/report_topics/:id' => 'topics#render_report'
  post '/report_topics' => 'topics#create_report'

  #adminpanel controller
  get '/admin' => 'admin_panel#index'
  get '/admin_panel/destroy_user/:id' => 'admin_panel#destroy_user'

  #sessions controller
  get '/signin' => 'sessions#new'
  delete '/signout' => 'sessions#destroy'

  #forum controller
  get '/about' => 'forum#about'
  get '/help' => 'forum#help'

  #sections controller
  get '/sections/:id' => 'sections#show'
  get '/new_section' => 'sections#new'

  #topics controller
  get '/sections/:id/new' => 'topics#new'
  get '/sections/topics/:id' => 'topics#show'
  get '/report_posts/:id' => 'posts#render_report'
  get '/report_posts/' => 'posts#render_report'
  post '/report_posts' => 'posts#create_report'

  #users controller
  get '/signup' => 'users#new'

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
