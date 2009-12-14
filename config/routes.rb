ActionController::Routing::Routes.draw do |map|
  map.resources :repositories
  map.resources :public_keys
  map.resources :users
  map.resource  :user_session
  map.resource  :account, :controller => "users"
  
  map.root :controller => "user_sessions", :action => "new"
  
  map.login   '/login',   :controller => "user_sessions", :action => "new"
  map.logout  '/logout',  :controller => "user_sessions", :action => "destroy", :method => "delete"
  
  map.profile '/:login',  :controller => "users",         :action => "profile"
  
  map.connect '/repositories/revoke_member/:id/:repo_id', :controller => "repositories", :action => "revoke_member"
  
  map.tree '/:login/:repo/tree/:branch/*path', :controller => "tree", :action => "tree"
  map.blob '/:login/:repo/blob/:branch/*path', :controller => "tree", :action => "blob"
  map.commits '/:login/:repo/commits/:branch', :controller => "tree", :action => "commits"
  map.manage '/:login/:repo/manage', :controller => "repositories", :action => "edit"
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
