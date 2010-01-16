class UsersController < ApplicationController
  
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update, :profile]
 
  def new
    @user = User.new
  end
 
  def create
    @user = User.new(params[:user])
    
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end
 
  def show
    @title = "Account - Gitty"
    @user = @current_user
    @keys = @current_user.public_keys
    @public_key = PublicKey.new
  end
  
  def profile
    @title = "#{@current_user.login}'s Profile"
    @user = User.find_by_login(params[:login])
    @repos = @user.repositories
  end
 
  def edit
    @title = "Edit - #{@current_user.login}"
    @user = @current_user
  end
 
  def update
    @user = @current_user
    
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end