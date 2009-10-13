# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gmcommerce_session',
  :secret      => '3f6391372ac0c0e23fc665a53b356dc7f68bd65eaf1edd2bbef7cea9c9dd8169323a426e1a4a8378dfac3062befe3579c6456692d3b5d53d7955d40af0b3d5bf'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
