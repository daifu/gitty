class TreeController < ApplicationController
  
  before_filter :require_user
  
  def tree
    @repository = Repository.find_by_name(params[:repo])
    
    if @repository && fetch_repo
      fetch_data
      @contents = @file.contents
    else
      redirect_to repositories_path
    end
  end
  
  def blob
    @repository = Repository.find_by_name(params[:repo])
    
    if @repository && fetch_repo
      fetch_data
      @data = @file.data
      @code = CodeRay.scan("\t" + @data, :ruby).div
    else
      redirect_to repositories_path
    end
  end
  
  def commits
    @repository = Repository.find_by_name(params[:repo])
    
    if @repository && fetch_repo
      @branches = @repo.heads
      @commits = @repo.commits(params[:branch])
    else
      redirect_to repositories_path
    end
  end
  
  private
  
    def fetch_repo
      begin
        @repo = Grit::Repo.new("#{RAILS_ROOT}/home/git/repositories/#{params[:login]}/#{params[:repo]}.git")
      rescue
        return false
      end
    end
    
    def fetch_data
      @branches = @repo.heads
      @commit = @repo.commit(params[:branch])
      @path = !params[:path].blank? ? params[:path].join("/") : "/"
      @file = @commit.tree / @path
    end 
end