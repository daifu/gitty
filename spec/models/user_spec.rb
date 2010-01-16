require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do  
  
  before(:each) do
    @user = Factory.build(:valid_user)
  end
  
  it "should be valid given valid params" do
    @user.should be_valid
  end
  
  it "should be invalid if login is nil" do
    @user.login = nil
    @user.should be_invalid
  end
  
  it "should be invalid if email is nil" do
    @user.email = nil
    @user.should be_invalid
  end
end