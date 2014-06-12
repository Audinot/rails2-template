# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_myapp_session',
  :secret      => 'a1dcc2cc7a0cb3cd0d5d220ac03b6d69d5325ec3c52d8d177cae54cc4fcaf56c8312cd440806a715a51b38ffe30386125cc7e5412f47ff8c7fa7ca51d386ba21'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
