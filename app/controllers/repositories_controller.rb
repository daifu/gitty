class RepositoriesController < ApplicationController
  
  before_filter :require_user
  include Grit
  
  # Show all repositories
  def index
    @repositories = @current_user.repositories
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @repository = Repository.find_by_name(params[:repo])
    if get_repo
      @branches = @repo.heads
    
      if params[:type] == 'blob'
        blob(@repo)
        respond_to do |format|
          format.html { render :template => "repositories/blob" }
        end
      else
        tree(@repo)
        respond_to do |format|
          format.html { render :template => "repositories/tree" }
        end
      end
    else
      flash[:notice] = 'Repo is Empty. Initialize by Pushing. (Instructions Coming Soon)'
      redirect_to(account_url)
    end
  end

  def new
    @repository = Repository.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    if @repository = @current_user.repositories.find(params[:id])
      return true
    else
      flash[:notice] = 'You are not allowed to access this repo'
      redirect_to(account_url)
    end
  end

  # Creates a new repo at the same time creates
  # the necessary configuration inside gitosis.conf
  def create
    @repository = Repository.new(params[:repository])
    @repository.name.strip! if @repository.name.match(/ /)
    @repository.name.gsub!(/ /, "-")
    
    respond_to do |format|
      if @repository.save && create_repository && create_repositories_users(@repository)
        flash[:notice] = 'Repository was successfully created.'
        format.html { redirect_to(repositories_url) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    if @repository = @current_user.repositories.find(params[:id])
      respond_to do |format|
        if @repository.update_attributes(params[:repository])
          flash[:notice] = 'Repository was successfully updated.'
          format.html { redirect_to(repositories_url) }
        else
          format.html { render :action => "edit" }
        end
      end
    else
      flash[:notice] = 'You are not allowed to access this repo'
      redirect_to(account_url)
    end
  end

  def destroy
    if @repository = @current_user.repositories.find(params[:id])
      @repository.destroy
    else
      flash[:notice] = 'You are not allowed to access this repo'
      redirect_to(account_url)
    end

    respond_to do |format|
      format.html { redirect_to(repositories_url) }
    end
  end
  
  def blob(repo)
    @blob = repo.blob(params[:path].last)
    @data = @blob.data
    @code = CodeRay.scan(@data, :ruby).html(:line_numbers => :table).div
  end
  
  def tree(repo)
    if @head = repo.get_head(params[:branch])
      @commit = @head.commit
    else
      @commit = repo.commit(params[:branch])
    end
    
    if params[:path]
      @tree = @commit.tree / params[:path].join("/")
    else
      @tree = @commit.tree
    end
    @contents = @tree.contents
  end
  
  def commits
    get_repo
    
    if params[:branch]
      @commits = @repo.commits(params[:branch])
    else
      @commits = @repo.commits
    end
  end
  
  def show_commit
    if get_repo
      
    end
  end
  
  def manage
    @repository = @current_user.repositories.find_by_name(params[:repo])
    show_collaborators(@repository)
  end
  
  def add_members
    users = params[:user][:login].split(" ")
    @repository = Repository.find_by_name(params[:user][:repo])
    users.each do |u|
      user = User.find_by_login(u)
      RepositoriesUsers.new({:repository_id => @repository.id, :user_id => user.id, :is_owner => @repository.owner.id}).save
      append_member_to_group(user, @repository)
    end
    show_collaborators(@repository)
    render :update do |page|
      page.replace_html "member_list", :partial => 'member_list'
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
    # TODO Change the file being opened later in production
    def create_repository
      # file = File.open(preference.gitosis_conf_file)
      begin
          file = File.open("#{RAILS_ROOT}/home/git/repositories/gitosis-admin.git/gitosis.conf", "a+")
          file.puts "\n"
          file.puts "[group #{params[:repository][:name]}]"
          file.puts "writable = #{@current_user.login}/#{params[:repository][:name]}"
          file.puts "members = #{@current_user.login}"
          file.close
          return true
      rescue
        return false
      end
    end
    
    def create_repositories_users(repository)
      RepositoriesUsers.new({:repository_id => repository.id, :user_id => @current_user.id, :is_owner => @current_user.id}).save
    end
    
    def get_repo
      begin
        @repo = Repo.new("#{RAILS_ROOT}/home/git/repositories/#{params[:login]}/#{params[:repo]}.git")
      rescue
        return false
      end
    end
    
    def revoke_member_in_gitosis(revoke_member, repository)
      begin
        line = "[group #{repository.name}]"
        name = " #{revoke_member} "
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
