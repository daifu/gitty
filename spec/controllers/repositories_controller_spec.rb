require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RepositoriesController do
  
  before(:each) do
    login(:id => 1)
  end
  
  describe "repository pages" do
    integrate_views
    
    it "should have a working index page" do
      get :index
      response.should be_success
      response.should render_template("index")
    end
    
    it "should have a working new page" do
      get :new
      response.should be_success
      response.should render_template("new")
    end
  end
end
