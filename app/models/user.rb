class User < ActiveRecord::Base
  has_many  :repositories, :dependent => :destroy
  has_many  :public_keys, :dependent => :destroy
  has_and_belongs_to_many :repositories
  acts_as_authentic
end
