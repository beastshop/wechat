Wechat::Application.routes.draw do
  devise_for :users

  resources :message_keywords
  resources :message_auto_reply_musics
  resources :message_auto_reply_texts
  resources :message_auto_reply_news
  resources :message_auto_reply_news_articles
  resources :magento_customers, :only => [:index, :destroy]
  resources :card_logs, :only => [:index]
  resources :message_receives
  
  get 'cards/index_byuser'
  get 'cards/index'
  get 'cards/show_code'
  
  match 'cards/:id' => 'cards#show'

  # get 'magento_customers/index'
  post 'message_auto_reply_texts/new_model'
  post 'message_auto_reply_texts/destroy'
  post 'message_auto_reply_musics/destroy'
  post 'message_auto_reply_news/destroy'
  
  match 'message_receives' => 'message_receives#index'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
  get '/api' => 'api/common#test'
  scope :path => "/api", :via => :post, :defaults => {:format => 'xml'} do
    root :to => 'api/common#echo'
    # root :to => 'api/users#welcome', :constraints => Wechat::Router.new(:type => "text", :content => "Hello2BizUser")
    # root :to => 'weixin/staffs#show', :constraints => Wechat::Router.new(:type => "text", :content => /^@/)
    # root :to => 'weixin/staff_photos#update', :constraints => Wechat::Router.new(:type => "text", :content=>/^#photo /)
    # root :to => 'weixin/staffs#index', :constraints => Wechat::Router.new(:type => "text")
    # root :to => 'weixin/staff_photos#create', :constraints => Wechat::Router.new(:type => "image")
  end

    namespace :the_beast do
      # Directs /admin/products/* to Admin::ProductsController
      # (app/controllers/admin/products_controller.rb)
      resources :sessions do
        collection do
          get 'success'
        end
      end
    end

  get '/' => 'cards#index' 
  
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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
