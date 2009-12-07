ActionController::Routing::Routes.draw do |map|
  map.resources :product_sets

  map.resources :product_sets

  map.resources :wish_list_items, :only=>[:index]


  map.resources :pages, :only=>[:show], :as=>"s"
  map.resources :property_types
  map.resources :orders, :new => { :preview => :post }
  map.resource :payment, :only => [:new], :member=>{:success=>:get, :failed=>:get}
  map.resource :cart, :member=>{:add_product_to=>:post, :set_product_quantity_in=>:post, :delete_product_in=>:post, :set_shipment_for=>:post, :change_variation_in=>:post, :set_gateway_for=>:post}
  map.resources :products, :only=>[:show], :collection=>{:gifts=>:get, :gift_givers=>:get} do |product|
    product.resource :wish_list_item, :only=>[:create, :destroy]
  end
  map.resources :categories, :only=>[:index, :show]

  # HACK!
  map.admin "/admin", :controller=>"admin/orders", :action=>"index"
  map.namespace :admin do |admin|
    admin.resources :categories
    admin.resources :contacts
    admin.resources :gift_discounts
    admin.resources :menu_groups, :collection=>{:reorder=>:get, :sort=>:post} do |menu|
      menu.resources :menu_items, :collection=>{:reorder=>:get, :sort=>:post}
    end
    admin.resources :option_groups, :member=>{:reorder=>:get, :sort=>:post}
    admin.resources :orders, :member=>{:cancel=>:get, :pay=>:get, :send_order=>:get, :deliver=>:get}
    admin.resources :pages
    admin.resources :producers
    admin.resources :product_sets
    admin.resources :products, :collection=>{:reorder=>:get, :sort=>:post} do |product|
      product.resources :comments
    end
    admin.resources :property_types, :collection=>{:reorder=>:get, :sort=>:post}
    admin.resources :product_templates
    admin.resource :setting, :only => [:update, :show]
    admin.resources :shipments
    admin.resources :users, :member=>{:reset_password=>:get}
    admin.root :controller=>"admin/orders", :action=>"index"
  end


  map.resource :user_session
  map.login "/login", :controller=>"user_sessions", :action=>"new"
  map.signup "/signup", :controller=>"users", :action=>"new"
  map.resource :account, :controller => "users"
  map.resources :users
  map.resources :password_resets

  map.root :controller => "gmcommerce", :action => "index" # optional, this just sets the root route


  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
  
end
