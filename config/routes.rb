ActionController::Routing::Routes.draw do |map|
  map.resources :repositories
  map.resources :public_keys
  map.resource :user_session
  map.resource :account, :controller => "users"
  map.resources :users
  map.root :controller => "user_sessions", :action => "new"
  
  # shows user profile
  map.profile '/:login', :controller => "users", :action => "profile"
  
  # Repositories Routes
  map.connect '/repositories/revoke_member/:id/:repo_id', :controller => "repositories", :action => "revoke_member"
  map.manage '/:login/:repo/manage', :controller => "repositories", :action => "edit"
  map.commits '/:login/:repo/commits/:branch', :controller => "tree", :action => "commits"
  map.content '/:login/:repo/:type/:branch/*path', :controller => "tree", :action => "show"
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
