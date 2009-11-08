class RepositoriesController < ApplicationController
  
  before_filter :require_user
  
  def index
    @repositories = @current_user.repositories
    
    respond_to do |format|
      format.html
    end
  end

  def new
    @repository = Repository.new
    
    respond_to do |format|
      format.html
    end
  end

  def edit
    @repository = @current_user.repositories.find_by_name(params[:repo])
      
    if @repository
      show_collaborators(@repository)
    else
      flash[:notice] = 'You are not allowed to access this repo'
      redirect_to(repositories_url)
    end
  end

  def create
    @repository = Repository.new(params[:repository])
    
    respond_to do |format|
      if @repository.save
        flash[:notice] = 'Repository was successfully created.'
        format.html { redirect_to(repositories_url) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @repository = @current_user.repositories.find(params[:id])
    
    respond_to do |format|
      if @repository
        if @repository.update_attributes(params[:repository])
          flash[:notice] = 'Repository was successfully updated.'
          format.html { redirect_to(repositories_url) }
        else
          format.html { render :action => "edit" }
        end
      else
        flash[:notice] = 'You are not allowed to access this repo'
        format.html { redirect_to(repositories_url) }
      end
    end
  end

  def destroy
    @repository = @current_user.repositories.find(params[:id])
      
    respond_to do |format|
      if @repository.destroy
        flash[:notice] = 'Repository has been deleted'
      else
        flash[:notice] = 'You are not allowed to access this repo'
      end
      format.html { redirect_to(repositories_url) }
    end
  end
  
  def add_members
    @repository = Repository.find_by_name(params[:user][:repo])
    user = User.find_by_login(params[:user][:login])
    if !user.blank?
      create_repositories_users(@repository, user, @repository.user)
      append_member_to_group(user, @repository)
      show_collaborators(@repository)
      render :update do |page|
        page.replace_html "member_list", :partial => 'member_list'
      end
    else
      render :update do |page|
        page.insert_html(:top, "list_members", "<div class='notice'>No User Name Found In The Database.</div>")
      end
    end
  end

  def revoke_member
    @repository = Repository.find_by_id(params[:repo_id])
    revoke_member = RepositoriesUsers.find_by_id(params[:id])
    if revoke_member.is_owner != revoke_member.user_id
      remove_member_from_group(revoke_member.user.login, @repository)
      revoke_member.destroy
      show_collaborators(@repository)
      render :update do |page|
        page.replace_html "member_list", :partial => 'member_list'
      end
    else
      show_collaborators(@repository)
      render :update do |page|
        page.insert_html(:top, "list_members", "<div class='notice'>Your Are Not Allowed to Delete The Owner</div>")
      end
    end
  end

  def show_collaborators(repository)
    @members = repository.users
    members_ids = []
    @members.each do |m|
      members_ids << m.user_id
    end
    @users = User.find(:all, :conditions => ["id NOT IN (?)", members_ids])
    @auto_complete = [];
    @users.each do |m|
      @auto_complete << m.login
    end
    @auto_complete = ActiveSupport::JSON.encode(@auto_complete)
  end

  def append_member_to_group(member, repository)
    flash[:notice] = "Error in ssh key name!" unless add_ssh_key_name_to_group(member, repository)
  end

  def remove_member_from_group(member, repository)
    flash[:notice] = "Error in ssh key name!" unless revoke_member_in_gitosis(member, repository)
  end
  
  private
    
    def create_repositories_users(repository, member ,user)
      RepositoriesUsers.new({:repository_id => repository.id, :user_id => member.id}).save
    end
    
    def revoke_member_in_gitosis(revoke_member, repository)
      begin
        line = "[group #{repository.name}]"
        name = " #{revoke_member}"
        gsub_file "#{RAILS_ROOT}/home/git/repositories/gitosis-admin.git/gitosis.conf", /(#{Regexp.union(line, name)})/mi do |match|
          "#{match.gsub(/#{Regexp.escape(name)}/, "")}"
        end
        return true
      rescue
        return false
      end
    end

    def add_ssh_key_name_to_group(member, repository)
      begin
        line = "[group #{repository.name}]\nwritable = #{repository.owner.login}/#{repository.name}\nmembers ="
        gsub_file "#{RAILS_ROOT}/home/git/repositories/gitosis-admin.git/gitosis.conf", /(#{Regexp.escape(line)})/mi do |match|
          "#{match} #{member.login}"
        end
        return true
      rescue
        return false
      end
    end

    def gsub_file(path, regexp, *args, &block)
      content = File.read(path).gsub(regexp, *args, &block)
      File.open(path, 'wb') { |file| file.write(content) }
    end
end
