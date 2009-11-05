require 'spec_helper'

describe TreeController do
  
  before(:each) do
    authenticate(:id => 1)
  end
  
  it "should render template tree/tree with valid params for a tree" do
    get :show, :repo => "gitup", :branch => "master", :type => "tree"
    response.should render_template("tree/tree")
  end
  
  it "should render template tree/blob with valid params for a blob" do
    get :show
    response.should render_template("tree/blob")
  end
  
  it "should redirect when given invalid params" do
    get :show
    response.should be_redirect
  end
end
