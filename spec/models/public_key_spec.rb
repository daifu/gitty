require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PublicKey do
  
  before(:each) do
    @public_key = Factory.build(:valid_public_key)
  end

  it "should create a new instance given valid attributes" do
    @public_key.should be_valid
  end
  
  it "should be invalid without title" do
    @public_key.title = nil
    @public_key.should be_invalid
  end
  
  it "should be invalid without key" do
    @public_key.key = nil
    @public_key.should be_invalid
  end
  
  it "should be invalid using :invalid_public_key factory" do
    Factory.build(:invalid_public_key).should be_invalid
  end
end
