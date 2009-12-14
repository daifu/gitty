require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do  
  
  before(:each) do
    @user = Factory.build(:valid_user)
  end
  
  it "should be valid" do
    @user.should be_valid
  end
  
  it "should succeed creating a new :valid_user from the Factory" do
    Factory.create(:valid_user)
  end

  it "should be invalid using :invalid_user factory" do
    Factory.build(:invalid_user).should be_invalid
  end
  
end