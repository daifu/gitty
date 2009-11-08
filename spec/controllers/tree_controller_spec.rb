require 'spec_helper'

describe TreeController do
  
  before(:each) do
    authenticate(:id => 1)
  end
  
  describe "tree method" do  
    # it "should render tree given valid params" do
    #   get :tree,  :login => "daifu",
    #               :repo => "gitnub",
    #               :branch => "master"
    #   response.should be_success
    # end
  
    it "should redirect given invalid params" do
      get :tree,  :login => "daifu",
                  :repo => "gitnub123",
                  :branch => "master"
      response.should redirect_to(repositories_path)
    end
  end
  
  # describe "blob" do
  #   it "should render blob given valid params" do
  #     get :blob,  :login => "daifu",
  #                 :repo => "gitnub", 
  #                 :branch => "master",
  #                 :path => ".gitignore"
  #     response.should be_success
  #   end
  # end
  
  # it "should render tree given valid params for a blob" do
  #   get :tree,  :login => "daifu",
  #               :repo => "gitnub", 
  #               :branch => "master"
  #   response.should be_redirect
  # end
  
  # it "should render template tree/blob with valid params for a blob" do
  #   get :show
  #   response.should render_template("tree/blob")
  # end
  # 
  # it "should redirect when given invalid params" do
  #   get :show
  #   response.should be_redirect
  # end
end
