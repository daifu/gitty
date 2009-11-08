class PublicKey < ActiveRecord::Base
  
  belongs_to :user
  
  validates_presence_of   :title, :message => "can't be blank"
  validates_uniqueness_of :title, :message => "must be unique"
  
  validates_presence_of   :key, :message => "can't be blank"
  validates_uniqueness_of :key, :message => "must be unique"
  
  before_save     :strip_spaces
  after_create    :insert_key_to_file
  before_update   :update_key_file
  before_destroy  :remove_key_from_file
  
  def strip_spaces
    self.key.gsub!(/[\r\n,\n]/, '') if self.key.match(/\n/)
  end
  
  def insert_key_to_file
    begin
      File.open("#{RAILS_ROOT}/home/git/repositories/gitosis-admin.git/keydir/#{user.login}.pub", "a+") { |file| file.puts(self.key) }
    rescue
      return false
    end
  end
  
  def remove_key_from_file
    begin
      content = File.read("#{RAILS_ROOT}/home/git/repositories/gitosis-admin.git/keydir/#{user.login}.pub").gsub(key + "\n", "")
      File.open("#{RAILS_ROOT}/home/git/repositories/gitosis-admin.git/keydir/#{user.login}.pub", "w") { |file| file.write(content) }
    rescue
      return false
    end
  end
  
  def update_key_file
    begin
      # File.open(path, 'wb') { |file| file.write(content) } #TODO finish update logic for public keys
    rescue
      return false
    end
  end
end
