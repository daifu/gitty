# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gitty_session',
  :secret      => '84bc0972b9e543ac1fc430343427bb313f5a283f6930a7378cf92ee29f570e8da04ca1aedbb84e4f3f584a90bcf6cc5eab28ab7e50e44f9a8ed1481d2d64d52f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
