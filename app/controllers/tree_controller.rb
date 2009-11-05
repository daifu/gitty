class TreeController < ApplicationController
  
  before_filter :require_user
  
  def show
    @repository = Repository.find_by_name(params[:repo])
    
    if @repository && fetch_repo
      @branches = @repo.heads
      @commit = @repo.commit(params[:branch])
      @path = !params[:path].blank? ? params[:path].join("/") : "/"
      @file = @commit.tree / @path
    
      case params[:type]
      when 'blob'
        @data = @file.data
        @code = CodeRay.scan("\t" + @data, :ruby).div
        render :template => "tree/blob"
      when 'tree'
        @contents = @file.contents
        render :template => "tree/tree"
      end
    end
  end
  
  def commits
    @repository = Repository.find_by_name(params[:repo])
    
    if @repository && fetch_repo
      @branches = @repo.heads
      @commits = @repo.commits(params[:branch])
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
end
