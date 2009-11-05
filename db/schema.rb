# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091031041520) do

  create_table "preferences", :force => true do |t|
    t.string   "repositories_directory", :default => "/home/git/repositories",                                         :null => false
    t.string   "gitosis_directory",      :default => "/home/git/gitosis",                                              :null => false
    t.string   "keydir",                 :default => "/home/git/repositories/gitosis-admin.git/gitosis-export/keydir", :null => false
    t.string   "gitosis_conf_file",      :default => "/home/git/repositories/gitosis-admin.git/gitosis.conf",          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "public_keys", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repositories", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.string   "homepage"
    t.boolean  "is_public",   :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repositories_users", :force => true do |t|
    t.integer  "repository_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                                  :null => false
    t.string   "email",                                  :null => false
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.string   "persistence_token",                      :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.boolean  "is_admin",            :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
