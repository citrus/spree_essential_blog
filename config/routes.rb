Spree::Core::Engine.routes.append do
  
  scope(:module => "blog") do
    
    constraints(
      :year  => /\d{4}/,
      :month => /\d{1,2}/,
      :day   => /\d{1,2}/
    ) do 
      get '/blog/:year(/:month(/:day))' => 'posts#index', :as => :post_date
      get '/blog/:year/:month/:day/:id' => 'posts#show',  :as => :full_post
      get '/blog/category/:id' => 'post_categories#show', :as => :post_category
    end
    
    get '/blog/search/:query', :to => 'posts#search', :as => :search_posts, :query => /.*/
        
    resources :posts, :path => 'blog' do
      get :archive, :on => :collection
    end
  
    namespace :admin do
    
      resources :posts do 
        resources :images,   :controller => "post_images" do
          collection do
            post :update_positions
          end
        end
        resources :products, :controller => "post_products"
        resources :categories, :controller => "post_categories"
      end
      
      resource :disqus_settings
      
    end    
    
  end  
end
