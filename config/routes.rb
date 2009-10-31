ActionController::Routing::Routes.draw do |map|
  map.resources :repositories
  map.resources :public_keys
  map.resource :user_session
  map.resource :account, :controller => "users"
  map.resources :users
  map.root :controller => "user_sessions", :action => "new"
  
  # Users Routes
  map.profile '/:login', :controller => "users", :action => "profile"
  
  # Repositories Routes
  map.manage '/:login/:repo/manage', :controller => "repositories", :action => "manage"
  map.repo '/:login/:repo/:branch', :controller => "repositories", :action => "show"
  map.commits '/:login/:repo/commits/:branch', :controller => "repositories", :action => "commits"
  map.content '/:login/:repo/:branch/:type/*path', :controller => "repositories", :action => "show"
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
