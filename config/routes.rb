Muzik::Application.routes.draw do
  resources :media_players do
    collection do
      get 'datatable'
      get 'delete'
      get 'location_info'
      get 'songs_library'
      get 'blacklisted_songs'
      get 'playlists'
    end
  end

  resources :dashboard
  resources :group_holiday_schedules

  resources :playlists do
    collection do
      get 'display'
      get 'fetch'
    end
  end

  resources :energy_levels

  resources :locations do
    collection do
      get 'datatable'
      get 'delete'
      get 'blacklist_songs'
    end
  end

  resources :black_lists do
    collection do
      get 'fetch'
    end
  end

  resources :group_song_assignments do
    collection do
      get 'upload_itunes_plist'
      post 'upload_itunes_plist'
    end
  end

  resources :song_libraries

  resources :groups do
    collection do
      get 'datatable'
      get 'remove_location'
      post 'add_location'
      post 'add_holiday_schedule'
      get 'delete'
      get 'playlists'
      get 'songstable'
      get 'songs'
      get 'remove_group_song_assignment'
    end
  end

  resources :songs do
    collection do
      get 'upload'
      get 'datatable'
      get 'datatable2'
      get 'autocomplete_song_title'
      post 'add_tag'
    end
  end

  resources :taggings
  resources :tests

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
  # root :to => 'welcome#index'
  root :to => 'dashboard#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
