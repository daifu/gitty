require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
  
  def populate_users_table
    Factory.create(:valid_user)
  end
  
  it "should GET/new view" do
    get :new
    assigns(:user).should_not be_nil
    response.should be_success
  end
  
  it "should POST/create when given valid data" do
    post :create, :user => Factory.attributes_for(:valid_user)
    response.should redirect_to(account_url)
  end
  
  it "should not GET/show view if logged in" do
    authenticate
    get :show, :id => 1
    response.should be_success
  end
  
  it "should not GET/show view if not logged in" do
    get :show, :id => 1
    response.should_not be_success
  end
end
