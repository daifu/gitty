require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Preference do
  before(:each) do
    @preference = Factory.build(:valid_preference)
  end

  it "should create a new instance given valid attributes" do
    @preference.should be_valid
    @preference.save!
  end
  
  it "should be invalid using :invalid_preference factory" do
    Factory.build(:invalid_preference).should be_invalid
  end
end
