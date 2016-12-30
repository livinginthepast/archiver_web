require 'action_dispatch/middleware/session/dalli_store'

# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :dalli_store, key: '_admin_session'

Rails.application.config.session_store ActionDispatch::Session::CacheStore,
  cache: ActiveSupport::Cache::MemCacheStore.new(
    '127.0.0.1:11211', {
      namespace: 'avr',
      keepalive: true,
      key: '_archiver_session'
    }
)
