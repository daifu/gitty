require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSessionsController do
  
  it "should get new user session" do
    get :new
    response.should be_success
  end

  it "should create a new session if valid" do
    Factory.create(:valid_user)
    post :create, :user_session => Factory.attributes_for(:valid_user)
    response.should redirect_to(repositories_url)
  end
  
  it "should destroy user session" do
    delete :destroy, :id => 1
    response.should be_redirect 
  end
end
