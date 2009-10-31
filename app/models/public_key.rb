class PublicKey < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title, :message => "can't be blank"
  validates_presence_of :key, :message => "can't be blank"
  validates_uniqueness_of :title, :message => "must be unique"
  validates_uniqueness_of :key, :message => "must be unique"
end
