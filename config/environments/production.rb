Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.require_master_key = true
  config.read_encrypted_secrets = true
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.js_compressor = :uglifier
  config.assets.compile = true
  config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  config.active_storage.service = :local
  config.log_level = :info
  config.log_tags = [ :request_id ]
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.active_record.dump_schema_after_migration = false
  config.action_view.raise_on_missing_translations = false

  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: 'bit.informatom.com' }
  config.action_mailer.default_options = { from: "exception-mailer@informatom.com" }
  config.action_mailer.smtp_settings = {
    address:              'box.bravepi.org',
    port:                 587,
    domain:               'informatom.com',
    user_name:            Rails.application.credentials.smtp[:username],
    password:             Rails.application.credentials.smtp[:password],
    authentication:       :login,
    enable_starttls_auto: true }

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end
end
