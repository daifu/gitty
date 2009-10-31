require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSessionsController do
  
  def populate_user_table
    Factory.create(:valid_user)
  end

  it "should get new user session" do
    get :new
    assigns(:user_session).should_not be_nil
    response.should be_success
  end

  it "should create a new session if valid" do
    populate_user_table
    post :create, :user_session => Factory.attributes_for(:valid_user)
    response.should redirect_to(repositories_url)
  end
  
  it "should destroy user session" do
    delete :destroy, :id => 1
    response.should be_redirect 
  end
end
