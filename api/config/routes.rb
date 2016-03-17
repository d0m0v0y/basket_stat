Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  default_url_options :host => "localhost:3000"

  # devise_for :users

  root to: 'stats#index'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :championships do
        resources :seasons do
          get '/teams', to: 'season_teams#index'
          post '/add_teams', to: 'season_teams#add_teams'
          post '/remove_teams', to: 'season_teams#remove_teams'
        end
      end

      resources :teams
      resources :players
      resources :games do
        post '/start', to: 'games#start'
        post '/finish', to: 'games#finish'
      end
      resources :game_events
      resources :player_times
      patch 'player_times' => 'player_times#update'

      # resources :statistics
      get '/statistics', to: 'statistics#show'
      # get '/statistics/:game_id/player/:player_id' => 'statistics#player'
      # get '/statistics/:game_id/team/:team_id' => 'statistics#team'

      resources :lineups
      # post '/lineups', to: 'lineups#create'
      # get '/lineups', to: 'lineups#show'
    end
  end



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
