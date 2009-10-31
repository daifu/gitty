module RepositoriesHelper
  
  def traverse_tree(filename)
    if params[:path]
      path = build_array(filename)
      @log = @repo.log(params[:branch], path.join("/")).first
    else
      @path_array = filename
      @log = @repo.log(params[:branch], filename).first
    end
  end
  
  def create_glob(filename)
    if params[:path]
      build_array(filename)
    else
      filename
    end
  end
  
  def build_array(filename)
    new_path_array = Array.new(params[:path])
    new_path_array.push(filename)
  end
  
  def is_repo_owner?(repo)
    return true if @current_user == Repository.find_by_name(repo).owner
  end
end
