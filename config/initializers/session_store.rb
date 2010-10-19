# Be sure to restart your server when you modify this file.

# Always ActionController::InvalidAuthenticityToken
#Rails.application.config.session_store :cookie_store, :key => '_shopqi_session', :domain => :all
domain = production? ? '.shopqi.com' : '.lvh.me'
Rails.application.config.session_store :cookie_store, :key => '_shopqi_session', :domain => domain

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# Rails.application.config.session_store :active_record_store
