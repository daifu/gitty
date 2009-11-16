require 'spec_helper'

describe TreeController do
  
  before(:each) do
    login(:id => 1)
    Factory.create( :valid_repo,
                    :name => "gitnub" )
  end
  
  describe "tree" do
    integrate_views
    
    it "should render tree given valid params" do
      get :tree,  :login  => "daifu",
                  :repo   => "gitnub",
                  :branch => "master"
      response.should be_success
      response.should render_template("tree")
    end
  
    it "should redirect given invalid params" do
      get :tree,  :login  => "daifu",
                  :repo   => "gitnub123",
                  :branch => "master"
      response.should be_redirect
    end
  end
  
  describe "blob" do
    it "should render blob given valid params" do
      get :blob,  :login  => "daifu",
                  :repo   => "gitnub", 
                  :branch => "master",
                  :path   => [".gitignore"]
      response.should be_success
      response.should render_template("blob")
    end
  end
  
  describe "commits" do
    it "should render commits given valid params" do
      get :commits, :login  => "daifu",
                    :repo   => "gitnub",
                    :branch => "master"
      response.should be_success
      response.should render_template("commits")
    end
    
    it "should redirect given invalid params" do
      get :commits, :login  => "daifu",
                    :repo   => "gitnub123",
                    :branch => "master"
      response.should be_redirect
    end
  end
end
