class CreateUsers < ActiveRecord::Migration
  
  def self.up
    create_table :users do |t|
      t.string    :login,               :null => false                # optional, you can use email instead, or both
      t.string    :email,               :null => false                # optional, you can use login instead, or both
      t.string    :crypted_password,    :null => false                # optional, see below
      t.string    :password_salt,       :null => false                # optional, but highly recommended
      t.string    :persistence_token,   :null => false                # required
      t.string    :single_access_token, :null => false                # optional, see Authlogic::Session::Params
      t.string    :perishable_token,    :null => false                # optional, see Authlogic::Session::Perishability

      # Magic columns, just like ActiveRecord's created_at and updated_at. These are automatically maintained by Authlogic if they are present.
      t.integer   :login_count,         :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.integer   :failed_login_count,  :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_request_at                                    # optional, see Authlogic::Session::MagicColumns
      t.datetime  :current_login_at                                   # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_login_at                                      # optional, see Authlogic::Session::MagicColumns
      t.string    :current_login_ip                                   # optional, see Authlogic::Session::MagicColumns
      t.string    :last_login_ip                                      # optional, see Authlogic::Session::MagicColumns
      t.boolean   :is_admin,            :null => false, :default => 0
      
      t.timestamps
    end
    
    User.create(:login => "admin",
                :email => "admin@email.com",
                :crypted_password => "5c23373e20bb06a72a12d097b7ba7e6f836b0711af66d8d393d15564c7eaade6231cca024f4fc7ec3bf759e08f81da04b5acb803b2e71f156342a73e2fd42bc9",
                :password_salt => "E_ej9P2PO8ng5sJQLa7E",
                :persistence_token => "6235cfb0753aa61b44da44fa97ccc05e53e4d1d980b17f5e48ccacb76a8a2d7b565d2aadb864106bd01fba040a2e633576a4dbb4b59e297055805187ad9b0757",
                :single_access_token => "FkkW88iS9B6T8nqeqi5Q",
                :perishable_token => "K8PzaUkNI0Y0kmYPi-20",
                :login_count => "1",
                :failed_login_count => "0",
                :last_request_at => "2009-10-31 02:13:27",
                :current_login_at => "2009-10-31 02:13:25",
                :last_login_at => nil,
                :current_login_ip => "127.0.0.1",
                :last_login_ip => nil,
                :is_admin => 1,
                :created_at => "2009-10-31 02:13:25",
                :updated_at => "2009-10-31 02:13:27")
    User.create(:login => "daifu",
                :email => "daifu.ye@gmail.com",
                :crypted_password => "c99787363052fa900c66b802ba0bd8baa21c52cb362b2414b276aafc8193fffef50579b1d6738ec6ae49bf4599c1ec5047b465bd74b8c08b1a4aa8496e0eb685",
                :password_salt => "bXnJvedCRRDRtvAJpziJ",
                :persistence_token => "fd05ce8df1d5f65415970540351fd2c7396407613dd86ad26138ea925a8eaeca65750c3b3a294ae777a55bad0523c63f845e512b9aefe79e2bb88477bf9ae845",
                :single_access_token => "NDtCY1k0sRNTz1hsZ7ZQ",
                :perishable_token => "ylYnxabn43rrY7CRyUzJ",
                :login_count => "1",
                :failed_login_count => "0",
                :last_request_at => "2009-10-31 02:13:27",
                :current_login_at => "2009-10-31 02:13:25",
                :last_login_at => nil,
                :current_login_ip => "127.0.0.1",
                :last_login_ip => nil,
                :is_admin => 0,
                :created_at => "2009-10-31 02:13:25",
                :updated_at => "2009-10-31 02:13:27")
  end

  def self.down
    drop_table :users
  end
end