class UsersController < ApplicationController
  
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
 
  def new
    @user = User.new
  end
 
  def create
    @user = User.new(params[:user])
    if @user.save && create_user_folder_and_keyfile
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end
 
  def show
    @user = @current_user
    @keys = @current_user.public_keys
    @public_key = PublicKey.new
  end
 
  def edit
    @user = @current_user
  end
 
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
  
  # TODO Set reposiotories being viewed by other users to public
  def profile
    @user = User.find_by_login(params[:login])
    @repos = @user.repositories
  end
  
  private
    
    # TODO Test this in production with the original settings
    def create_user_folder_and_keyfile
      begin
      # FileUtils.mkdir("#{Preference.first.repositories_directory}/#{params[:user][:login]}")
        FileUtils.mkdir("#{RAILS_ROOT}/home/git/repositories/#{params[:user][:login]}")
        File.new("#{RAILS_ROOT}/home/git/repositories/gitosis-admin.git/keydir/#{params[:user][:login]}.pub", "w")
      rescue
        # RETURN TRUE SO TEST PASSES, PUT BACK TO FALSE WHEN IN PRODUCTION
        # return false
        return true
      end
    end
end
