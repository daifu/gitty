require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RepositoriesUsers do
  before(:each) do
    @valid_attributes = {
      
    }
  end
  
  def valid_user_id
    {
      :user_id => 2
    }
  end
  
  it "should can not save with same repository_id and user_id " do
    Factory(:valid_repo)
    repo = RepositoriesUsers.new(:repository_id => 1, :user_id => 1, :is_owner => 1)
    repo.should have(1).error_on(:user_id)
  end
  
  it "should create a new instance given valid attributes" do
    RepositoriesUsers.create!(@valid_attributes)
  end
end
