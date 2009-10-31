class Repository < ActiveRecord::Base
  
  IMAGE_MIMES = ["image/png", "img/jpeg", "image/jpg", "image/gif", "img/bmp"]
  
  validates_presence_of :name, :message => "can't be blank"
  validates_uniqueness_of :name, :message => "must be unique"
  belongs_to  :owner, :class_name => "User", :foreign_key => "user_id"
  has_and_belongs_to_many :users
end
