class RepositoriesUsers < ActiveRecord::Base
  belongs_to  :user, :foreign_key => "user_id"
  validates_uniqueness_of :user_id, :message => "must be unique", :if => :repo_condition?
  
  def repo_condition?
    proc { |obj| return false if RepositoriesUsers.find(:all, :conditions => ["repository_id = ?", obj.repository_id], :select => :user_id).map(&:user_id).include?(obj.user_id) }
  end
end
