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
      if @repository.save && create_repository
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
    @users = User.all
  end
  
  def create_member
    @member = Member.new(params[:member])
    
    respond_to do |format|
      if @member.save
        flash[:notice] = "Member has been added"
        format.html { redirect_to(manage_url(@current_user.login, params[:repo])) }
      else
        flash[:notice] = "Cannot Add Member"
        format.html { redirect_to account_url }
      end
    end
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
    
    def get_repo
      begin
        @repo = Repo.new("#{RAILS_ROOT}/home/git/repositories/#{params[:login]}/#{params[:repo]}.git")
      rescue
        return false
      end
    end
end
