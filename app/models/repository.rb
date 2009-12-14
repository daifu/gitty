class Repository < ActiveRecord::Base
  
  IMAGE_MIMES = ["image/png", "img/jpeg", "image/jpg", "image/gif", "img/bmp"]
  
  validates_presence_of   :name,    :message => "can't be blank"
  validates_uniqueness_of :name,    :message => "must be unique"
  
  belongs_to              :user
  # has_and_belongs_to_many :members, :class_name => "User"
  
  before_create           :strip_whitespace
  after_save              :append_group
  
  def append_group
    file = File.open("#{RAILS_ROOT}/home/git/repositories/gitosis-admin.git/gitosis.conf", "a+")
    file.puts "\n"
    file.puts "[group #{name}]"
    file.puts "writable = #{user.login}/#{name}"
    file.puts "members = #{user.login}"
    file.close
  end
  
  def strip_whitespace
    self.name.strip! if self.name.match(/ /)
    self.name.gsub!(/ /, "-")
  end
  
end
