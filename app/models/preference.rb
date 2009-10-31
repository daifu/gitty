class Preference < ActiveRecord::Base
  validates_presence_of :repositories_directory, :on => :create, :message => "can't be blank"
  validates_presence_of :gitosis_directory, :on => :create, :message => "can't be blank"
end
