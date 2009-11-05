class CreatePublicKeys < ActiveRecord::Migration
  def self.up
    create_table :public_keys do |t|
      t.integer :user_id
      t.string  :title
      t.text    :key
      
      t.timestamps
    end
  end

  def self.down
    drop_table :public_keys
  end
end
