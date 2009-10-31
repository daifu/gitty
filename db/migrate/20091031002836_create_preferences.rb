class CreatePreferences < ActiveRecord::Migration
  def self.up
    create_table :preferences do |t|
      t.string :repositories_directory,       :null => false, :default => "/home/git/repositories"
      t.string :gitosis_directory,            :null => false, :default => "/home/git/gitosis"
      t.string :keydir,                       :null => false, :default => "/home/git/repositories/gitosis-admin.git/gitosis-export/keydir"
      t.string :gitosis_conf_file,            :null => false, :default => "/home/git/repositories/gitosis-admin.git/gitosis.conf"
      t.timestamps
    end
    Preference.create
  end

  def self.down
    drop_table :preferences
  end
end
