class CreateRepositories < ActiveRecord::Migration
  def self.up
    create_table :repositories do |t|
      t.integer :user_id
      t.string  :name
      t.text    :description
      t.string  :homepage
      t.boolean :is_public, :null => false, :default => false
      t.timestamps
    end
    
    Repository.create(:user_id => "2",
                      :name => "gitnub",
                      :description => "A Gitk-like application written in RubyCocoa that looks like it belongs on a Mac.", 
                      :is_public => 0, 
                      :created_at => "2009-10-31 02:28:08", 
                      :updated_at => "2009-10-31 02:28:08")
  end

  def self.down
    drop_table :repositories
  end
end
