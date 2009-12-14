class User < ActiveRecord::Base
  
  has_many                :public_keys,   :dependent => :destroy
  has_many                :repositories,  :dependent => :destroy
  # has_and_belongs_to_many :repositories
  
  after_create            :initialize_user_settings
  acts_as_authentic
  
  def initialize_user_settings
    # TODO change in production
    # FileUtils.mkdir("#{Preference.first.repositories_directory}/#{params[:user][:login]}")
    begin
      FileUtils.mkdir("#{RAILS_ROOT}/home/git/repositories/#{self.login}")
      File.new("#{RAILS_ROOT}/home/git/repositories/gitosis-admin.git/keydir/#{self.login}.pub", "w")
    rescue
      return false
    end
  end
end
