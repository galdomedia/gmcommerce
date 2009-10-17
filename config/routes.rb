ActionController::Routing::Routes.draw do |map|



  map.resource :cart, :member=>{:add_product_to=>:post, :set_product_quantity_in=>:post, :delete_product_in=>:post}
  map.resources :products, :only=>[:show], :collection=>{:gifts=>:get}
  map.resources :categories, :only=>[:index, :show]

  # HACK!
  map.admin "/admin", :controller=>"admin/products", :action=>"index"
  map.namespace :admin do |admin|
    admin.resources :categories
    admin.resources :gift_discounts
    admin.resources :option_groups
    admin.resources :pages
    admin.resources :producers
    admin.resources :products
    admin.resources :property_types
    admin.resources :product_templates
    admin.resources :shipments
    admin.resources :users, :member=>{:reset_password=>:get}
    admin.root :controller=>"admin/products", :action=>"index"
  end


  map.resource :user_session
  map.login "/login", :controller=>"user_sessions", :action=>"new"
  map.signup "/signup", :controller=>"users", :action=>"new"
  map.resource :account, :controller => "users"
  map.resources :users
  map.resources :password_resets

  map.root :controller => "categories", :action => "index" # optional, this just sets the root route


  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
