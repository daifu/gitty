class CreateRepositoriesUsers < ActiveRecord::Migration
  def self.up
    create_table :repositories_users do |t|
      t.integer :repository_id
      t.integer :user_id
      t.integer :is_owner
      t.timestamps
    end
    
    RepositoriesUsers.create(:repository_id => 1,
                              :user_id => 2,
                              :is_owner => 1,
                              :created_at => "2009-10-30 23:21:24",
                              :updated_at => "2009-10-30 23:21:24"
                              )
  end

  def self.down
    drop_table :repositories_users
  end
end
