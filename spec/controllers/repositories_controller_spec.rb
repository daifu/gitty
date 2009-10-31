require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RepositoriesController do
  
  before(:each) do
    authenticate(:id => 1)
  end

  it "should GET the index view" do
    get :index
    response.should be_success
  end

  it "should GET the show view and assign repository" do
    Factory.create(:valid_repo, :id => 1)
    get :show, :repo => "gitup", 
               :login => "william", 
               :branch => "master"
    assigns[:repository].should_not be_nil
    assigns[:repo].should_not be_nil
    assigns[:commit].should_not be_nil
    assigns[:tree].should_not be_nil
    assigns[:contents].should_not be_nil
    response.should be_success
  end

  it "should GET/new and and assign repository" do
    get :new
    assigns[:repository].should_not be_nil
  end

  it "should assign repository with valid id and render edit" do
    Factory.create(:valid_repo, :id => 1, 
                                :name => "Rails Repo")
    get :edit, :id => "1"
    response.should be_success
  end

  describe "POST create" do

    describe "with valid params" do
      it "should create a new repository and redirect" do
        post :create, :repository => Factory.attributes_for(:valid_repo)
        response.should redirect_to(repositories_url)
      end
    end

    describe "with invalid params" do
      it "should redirect" do
        post :create, :repository => Factory.attributes_for(:valid_repo, :name => nil)
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do
  
    describe "with valid params" do
      it "updates a valid repository" do
        Factory.create(:valid_repo, :id => "35")
        put :update, :id => "35", :repository => {:name => 'NewRepoName'}
        assigns[:repository].should_not be_nil
        response.should redirect_to(repositories_url)
      end
    end
    
    describe "with invalid params" do
      it "should render edit if does not have valid data" do
        Factory.create(:valid_repo, :id => "38")
        put :update, :id => "38", :repository => {:name => nil}
        assigns[:repository].should_not be_nil
        response.should render_template("edit")
      end
    end
  
  end

  describe "DELETE destroy" do
    
    it "should destroy the requested repository" do
      Factory.create(:valid_repo, :id => "2")
      delete :destroy, :id => "2"
    end

    it "should redirect to the repositories list" do
      Factory.create(:valid_repo, :id => "3", 
                                  :name => "railsrepo")
      delete :destroy, :id => "3"
      response.should redirect_to(repositories_url)
    end
  end
end
