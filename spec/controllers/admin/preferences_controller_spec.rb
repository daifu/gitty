require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::PreferencesController do
  before(:each) do
    authenticate(:is_admin => 1)
  end

  it "should GET the index view" do
    get :index
    response.should be_success
  end
end
