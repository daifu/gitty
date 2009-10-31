require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Repository do
  
  before(:each) do
    @repo = Factory.build(:valid_repo)
  end

  it "should create a new instance given valid attributes" do
    @repo.should be_valid
    @repo.save!
  end
  
  it "should be invalid using :invalid_repo factory" do
    Factory.build(:invalid_repo).should be_invalid
  end
end
