class User < ActiveRecord::Base
  has_many  :repositories, :dependent => :destroy
  has_many  :public_keys, :dependent => :destroy
  acts_as_authentic
end
