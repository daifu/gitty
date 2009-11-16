require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PublicKeysController do

  before(:each) do
    login
  end
  
  describe "edit" do
    it "should render edit" do
      
    end
  end

  describe "create" do
    it "should create a new public key given valid params" do
      post :create, :public_key => { :title => "server",
                                     :key   => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAvVwmMZwCrROdPEStvyUT8O5BfpNtcs5XbBMFHwmiUpsDZrD11gaPfGMar+S1KbjtEal7RWvNbX31KkFk2Oolfx7oanF8TxiuseL1iWpNf+g3fSJB7zisZKAu3agIYmK1mPnCmQxPLt9nHa5id5aV0CdrTd8ZmBp06l91KiWn+AeMk/7gig30INvofceu+O4tyqginUvNTpBoErZYvbgXvXbL6vQ58jgiYSXRYvOCT1UU45US/R5BjdY4xfye3NbUNGqq/ypQTewiwoscp6nXI7hImbD/KeLYTaLcbg0NHm7UX6ErZGn/qZHklQdKZAeM/4y4heVocvis1/Q+zNROlw== Server@Server.local" }
      flash[:notice].should == 'Public Key was successfully created'
      response.should redirect_to(account_url)
    end
    
    it "should not create a new public key given invalid params" do
      post :create, :public_key => { :title => "server2",
                                     :key   => nil }
      flash[:notice].should == 'Cannot add Public Key'
      response.should redirect_to(account_url)
    end
  end
end
