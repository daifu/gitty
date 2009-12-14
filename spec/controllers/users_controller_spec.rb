require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
  
  describe "new action" do
    
    it "should render new" do
      get :new
      assigns(:user).should_not be_nil
      response.should be_success
    end
  end
  
  describe "create action" do
    
    it "should redirect after creating a valid user" do
      post :create, :user => Factory.attributes_for(:valid_user)
      response.should redirect_to(account_url)
    end
  end
  
  describe "show action" do
    
    it "should render show" do
      login
      get :show, :id => 1
      response.should be_success
    end
    
    it "should redirect when not logged in" do
      get :show, :id => 1
      response.should be_redirect
    end
  end

end